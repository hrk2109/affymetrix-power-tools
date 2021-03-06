! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
!   Copyright by The HDF Group.                                               *
!   Copyright by the Board of Trustees of the University of Illinois.         *
!   All rights reserved.                                                      *
!                                                                             *
!   This file is part of HDF5.  The full HDF5 copyright notice, including     *
!   terms governing use, modification, and redistribution, is contained in    *
!   the files COPYING and Copyright.html.  COPYING can be found at the root   *
!   of the source code distribution tree; Copyright.html can be found at the  *
!   root level of an installed copy of the electronic HDF5 document set and   *
!   is linked from the top-level documents page.  It can also be found at     *
!   http://hdfgroup.org/HDF5/doc/Copyright.html.  If you do not have          *
!   access to either file, you may request a copy from help@hdfgroup.org.     *
! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
!
!
! This file contains FORTRAN90 interfaces for H5E functions
!
      MODULE H5E

        USE H5GLOBAL
      
      CONTAINS

!----------------------------------------------------------------------
! Name:		h5eclear_f
!
! Purpose:	Clears the error stack for the current thread. 
!
! Inputs:  
! Outputs:  
!		hdferr:		- error code		
!				 	Success:  0
!				 	Failure: -1   
! Optional parameters:
!		
!	
!
!
! Programmer:	Elena Pourmal
!		August 12, 1999	
!
! Modifications: 	Explicit Fortran interfaces were added for 
!			called C functions (it is needed for Windows
!			port).  April 6, 2001 
!
! Comment:		
!----------------------------------------------------------------------

          SUBROUTINE h5eclear_f(hdferr) 
!
!This definition is needed for Windows DLLs
!DEC$if defined(BUILD_HDF5_DLL)
!DEC$attributes dllexport :: h5eclear_f
!DEC$endif
!
            IMPLICIT NONE
            INTEGER, INTENT(OUT) :: hdferr  ! Error code

!            INTEGER, EXTERNAL :: h5eclear_c
!  MS FORTRAN needs explicit interface for C functions called here.
!
            INTERFACE
              INTEGER FUNCTION h5eclear_c()
              USE H5GLOBAL
              !DEC$ IF DEFINED(HDF5F90_WINDOWS)
              !MS$ATTRIBUTES C,reference,alias:'_H5ECLEAR_C'::h5eclear_c
              !DEC$ ENDIF
              END FUNCTION h5eclear_c
            END INTERFACE
            hdferr = h5eclear_c()
          END SUBROUTINE h5eclear_f

!----------------------------------------------------------------------
! Name:		h5h5eprint_f
!
! Purpose:	Prints the error stack in a default manner. 
!
! Inputs:  
! Outputs:  
!		hdferr:		- error code		
!				 	Success:  0
!				 	Failure: -1   
! Optional parameters:
!		name		- name of the file that
!				  contains print output		
!
! Programmer:	Elena Pourmal
!		August 12, 1999	
!
! Modifications: 	Explicit Fortran interfaces were added for 
!			called C functions (it is needed for Windows
!			port).  April 6, 2001 
!
! Comment:		
!----------------------------------------------------------------------

          SUBROUTINE h5eprint_f(hdferr, name)
!
!This definition is needed for Windows DLLs
!DEC$if defined(BUILD_HDF5_DLL)
!DEC$attributes dllexport :: h5eprint_f
!DEC$endif
!
            CHARACTER(LEN=*), OPTIONAL, INTENT(IN) :: name ! File name
            INTEGER, INTENT(OUT) :: hdferr          ! Error code
!            INTEGER, EXTERNAL :: h5eprint_c1, h5eprint_c2 
            INTEGER :: namelen

!  MS FORTRAN needs explicit interface for C functions called here.
!
            INTERFACE
              INTEGER FUNCTION h5eprint_c1(name, namelen)
              USE H5GLOBAL
              !DEC$ IF DEFINED(HDF5F90_WINDOWS)
              !MS$ATTRIBUTES C,reference,alias:'_H5EPRINT_C1'::h5eprint_c1
              !DEC$ ENDIF
              !DEC$ATTRIBUTES reference :: name
              INTEGER :: namelen
              CHARACTER(LEN=*),INTENT(IN) :: name
              END FUNCTION h5eprint_c1
            END INTERFACE
!  MS FORTRAN needs explicit interface for C functions called here.
!
            INTERFACE
              INTEGER FUNCTION h5eprint_c2()
              USE H5GLOBAL
              !DEC$ IF DEFINED(HDF5F90_WINDOWS)
              !MS$ATTRIBUTES C,reference,alias:'_H5EPRINT_C2'::h5eprint_c2
              !DEC$ ENDIF
              END FUNCTION h5eprint_c2
            END INTERFACE
            namelen = LEN(NAME)
            if (present(name)) then
               hdferr = h5eprint_c1(name, namelen) 
            else
            hdferr = h5eprint_c2() 
            endif
          END SUBROUTINE h5eprint_f

!----------------------------------------------------------------------
! Name:		h5eget_major_f
!
! Purpose:	Returns a character string describing an error specified 
!		by a major error number. 
!
! Inputs:  
!		error_no	- mojor error number 
! Outputs:  
!		name		- character string describing the error
!		hdferr:		- error code		
!				 	Success:  0
!				 	Failure: -1   
! Optional parameters:
!		
! Programmer:	Elena Pourmal
!		August 12, 1999	
!
! Modifications: 	Explicit Fortran interfaces were added for 
!			called C functions (it is needed for Windows
!			port).  April 6, 2001 
!
! Comment:		
!----------------------------------------------------------------------

          SUBROUTINE h5eget_major_f(error_no, name, hdferr)
!
!This definition is needed for Windows DLLs
!DEC$if defined(BUILD_HDF5_DLL)
!DEC$attributes dllexport :: h5eget_major_f
!DEC$endif
!
            INTEGER, INTENT(IN) :: error_no !Major error number
            CHARACTER(LEN=*), INTENT(OUT) :: name ! Character string describing
                                                  ! the error.
            INTEGER, INTENT(OUT) :: hdferr          ! Error code

!            INTEGER, EXTERNAL :: h5eget_major_c
!  MS FORTRAN needs explicit interface for C functions called here.
!
            INTERFACE
              INTEGER FUNCTION h5eget_major_c(error_no, name)
              USE H5GLOBAL
              !DEC$ IF DEFINED(HDF5F90_WINDOWS)
              !MS$ATTRIBUTES C,reference,alias:'_H5EGET_MAJOR_C'::h5eget_major_c
              !DEC$ ENDIF
              !DEC$ATTRIBUTES reference :: name
              INTEGER :: error_no
               CHARACTER(LEN=*) :: name 
              END FUNCTION h5eget_major_c
            END INTERFACE

            hdferr = h5eget_major_c(error_no, name) 
          END SUBROUTINE h5eget_major_f

!----------------------------------------------------------------------
! Name:		h5eget_minor_f
!
! Purpose:	Returns a character string describing an error specified 
!		by a minor error number. 
!
! Inputs:  
!		error_no	- minor error number 
! Outputs:  
!		name		- character string describing the error
!		hdferr:		- error code		
!				 	Success:  0
!				 	Failure: -1   
! Optional parameters:
!		
!	
!
!
! Programmer:	Elena Pourmal
!		August 12, 1999	
!
! Modifications: 	Explicit Fortran interfaces were added for 
!			called C functions (it is needed for Windows
!			port).  April 6, 2001 
!
! Comment:		
!----------------------------------------------------------------------

          SUBROUTINE h5eget_minor_f(error_no, name, hdferr)
!
!This definition is needed for Windows DLLs
!DEC$if defined(BUILD_HDF5_DLL)
!DEC$attributes dllexport :: h5eget_minor_f
!DEC$endif
!
            INTEGER, INTENT(IN) :: error_no !Major error number
            CHARACTER(LEN=*), INTENT(OUT) :: name ! Character string describing
                                                  ! the error
            INTEGER, INTENT(OUT) :: hdferr        ! Error code

!            INTEGER, EXTERNAL :: h5eget_minor_c
!  MS FORTRAN needs explicit interface for C functions called here.
!
            INTERFACE
              INTEGER FUNCTION h5eget_minor_c(error_no, name)
              USE H5GLOBAL
              !DEC$ IF DEFINED(HDF5F90_WINDOWS)
              !MS$ATTRIBUTES C,reference,alias:'_H5EGET_MINOR_C'::h5eget_minor_c
              !DEC$ ENDIF
              !DEC$ATTRIBUTES reference :: name
              INTEGER :: error_no
               CHARACTER(LEN=*) :: name 
              END FUNCTION h5eget_minor_c
            END INTERFACE

            hdferr = h5eget_minor_c(error_no, name) 
          END SUBROUTINE h5eget_minor_f
!----------------------------------------------------------------------
! Name:		h5eset_auto_f
!
! Purpose:	Turns automatic error printing on or off
!
! Inputs:  
!		printflag	- flag to turn automatic error
!				- Possible values are:
!				- 1 (on), 0 (off)
! Outputs:  
!		hdferr:		- error code		
!				 	Success:  0
!				 	Failure: -1   
! Optional parameters:
!		
!	
!
!
! Programmer:	Elena Pourmal
!		August 12, 1999	
!
! Modifications: 	Explicit Fortran interfaces were added for 
!			called C functions (it is needed for Windows
!			port).  April 6, 2001 
!
! Comment:		
!----------------------------------------------------------------------


          SUBROUTINE h5eset_auto_f(printflag, hdferr)
!
!This definition is needed for Windows DLLs
!DEC$if defined(BUILD_HDF5_DLL)
!DEC$attributes dllexport :: h5eset_auto_f
!DEC$endif
!
            INTEGER, INTENT(IN) :: printflag  !flag to turn automatic error
                                              !printing on or off
                                              !possible values are:
                                              !printon (1)
                                              !printoff(0)
            INTEGER, INTENT(OUT) :: hdferr          ! Error code

!            INTEGER, EXTERNAL :: h5eset_auto_c
!  MS FORTRAN needs explicit interface for C functions called here.
!
            INTERFACE
              INTEGER FUNCTION h5eset_auto_c(printflag)
              USE H5GLOBAL
              !DEC$ IF DEFINED(HDF5F90_WINDOWS)
              !MS$ATTRIBUTES C,reference,alias:'_H5ESET_AUTO_C'::h5eset_auto_c
              !DEC$ ENDIF
              INTEGER :: printflag
              END FUNCTION h5eset_auto_c
            END INTERFACE

            hdferr = h5eset_auto_c(printflag) 
          END SUBROUTINE h5eset_auto_f

      END MODULE H5E
          
