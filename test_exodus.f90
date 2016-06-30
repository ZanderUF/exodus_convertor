program test_exodus

implicit none

include "/Users/mausaj/seacas-exodus/include/exodusII.inc"

        real vers
        real openid
        integer exoid, cpu_ws, io_ws, ierr,PRTMSG
        character*(MXLNLN) title
        integer num_dim, num_nodes, num_elem, num_elem_blk
        integer num_node_sets, num_side_sets

        real x(8), y(8), dummy(1)  !--for defining coordinates
        character*(MXSTLN) coord_names(3)
        integer node_map(MAXNOD)
!-------Write ExodusII file------------!
        cpu_ws = 0 
        io_ws = 0 !indicates REAL*8 
        exoid  = excre('exodus_mesh.e', EXCLOB, cpu_ws, io_ws, ierr)
!-------Open ExodusII file-------------!
!        openid = exopen ('test.exo', EXREAD, cpu_ws, io_ws, vers, ierr)

!------required initialization---------!
!------initializes the size of mesh----!
        title = "Test"
        num_dim = 1 !--- # of dimensions
        num_nodes = 8 !--- # of nodal points
        num_elem = 8 !--- # of elements
        num_elem_blk= 2 !--- # element blocks
        num_node_sets= 2 !--- # of node sets
        num_side_sets= 2 !--- # of side sets         

        call expini (openid, title, num_dim, num_nodes, num_elem, & 
                num_elem_blk, num_node_sets, num_side_sets, ierr)

!-----Write coordinates-----!
        x(1) = 0.0
        x(2) = 1.0
        x(3) = 1.0
        x(4) = 0.0
        x(5) = 1.0
        x(6) = 2.0
        x(7) = 2.0
        x(8) = 1.0
        y(1) = 0.0
        y(2) = 0.0
        y(3) = 1.0
        y(4) = 1.0
        y(5) = 0.0
        y(6) = 0.0
        y(7) = 1.0
        y(8) = 1.0

        call expcor (exoid, x, y, dummy, ierr)
        coord_names(1) = 'xcoor'
        coord_names(2) = 'ycoor'

!------- write node order map
    do 10 i = 1, num_nodes
       node_map(i) = i
    continue
        
!------Close mesh file-----!
        call exclos (exoid, ierr)

end program test_exodus
