TARGETS = mk_vtk_curve_POLYDATA.vtk mk_vtk_curve_STRUCTURED_GRID.vtk mk_vtk_image_RECTILINEAR_GRID.vtk mk_vtk_image_STRUCTURED_GRID.vtk mk_vtk_image_STRUCTURED_POINTS.vtk mk_vtk_points_POLYDATA.vtk mk_vtk_points_UNSTRUCTURED_GRID.vtk mk_vtk_surface_POLYDATA.vtk mk_vtk_surface_STRUCTURED_GRID.vtk mk_vtk_surface_UNSTRUCTURED_GRID.vtk

.PHONY= all clean

all: $(TARGETS)

clean: 
	rm -f $(TARGETS) *~ *.bak

mk_vtk_curve_POLYDATA.vtk: mk_vtk_curve_POLYDATA.rb
	./mk_vtk_curve_POLYDATA.rb > mk_vtk_curve_POLYDATA.vtk

mk_vtk_curve_STRUCTURED_GRID.vtk: mk_vtk_curve_STRUCTURED_GRID.rb
	./mk_vtk_curve_STRUCTURED_GRID.rb > mk_vtk_curve_STRUCTURED_GRID.vtk

mk_vtk_image_RECTILINEAR_GRID.vtk: mk_vtk_image_RECTILINEAR_GRID.rb
	./mk_vtk_image_RECTILINEAR_GRID.rb > mk_vtk_image_RECTILINEAR_GRID.vtk

mk_vtk_image_STRUCTURED_GRID.vtk: mk_vtk_image_STRUCTURED_GRID.rb
	./mk_vtk_image_STRUCTURED_GRID.rb > mk_vtk_image_STRUCTURED_GRID.vtk

mk_vtk_image_STRUCTURED_POINTS.vtk: mk_vtk_image_STRUCTURED_POINTS.rb
	./mk_vtk_image_STRUCTURED_POINTS.rb > mk_vtk_image_STRUCTURED_POINTS.vtk

mk_vtk_points_POLYDATA.vtk: mk_vtk_points_POLYDATA.rb
	./mk_vtk_points_POLYDATA.rb > mk_vtk_points_POLYDATA.vtk

mk_vtk_points_UNSTRUCTURED_GRID.vtk: mk_vtk_points_UNSTRUCTURED_GRID.rb
	./mk_vtk_points_UNSTRUCTURED_GRID.rb > mk_vtk_points_UNSTRUCTURED_GRID.vtk

mk_vtk_surface_POLYDATA.vtk: mk_vtk_surface_POLYDATA.rb
	./mk_vtk_surface_POLYDATA.rb > mk_vtk_surface_POLYDATA.vtk

mk_vtk_surface_STRUCTURED_GRID.vtk: mk_vtk_surface_STRUCTURED_GRID.rb
	./mk_vtk_surface_STRUCTURED_GRID.rb > mk_vtk_surface_STRUCTURED_GRID.vtk

mk_vtk_surface_UNSTRUCTURED_GRID.vtk: mk_vtk_surface_UNSTRUCTURED_GRID.rb
	./mk_vtk_surface_UNSTRUCTURED_GRID.rb > mk_vtk_surface_UNSTRUCTURED_GRID.vtk

