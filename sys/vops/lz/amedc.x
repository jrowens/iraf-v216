# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

# AMED -- Vector median selection.  The selection is carried out in a temporary
# array, leaving the input vector unmodified.  Especially demanding applications
# may wish to call the asok routine directory to avoid the call to the memory
# allocator.

char procedure amedc (a, npix)

char	a[ARB]
int	npix

pointer	sp, aa
char	median
char	asokc()		# select the Kth smallest element from A

begin
	switch (npix) {
	case 1, 2:
	    return (a[1])

	case 3:
		if (a[1] < a[2]) {
		    if (a[2] < a[3])
			return (a[2])
		    else if (a[1] < a[3])
			return (a[3])
		    else
			return (a[1])
		} else {
		    if (a[2] > a[3])
			return (a[2])
		    else if (a[1] < a[3])
			return (a[1])
		    else
			return (a[3])
		}

	default:
	    call smark (sp)
	    call salloc (aa, npix, TY_CHAR)
	    call amovc (a, Memc[aa], npix)
	    median = asokc (Memc[aa], npix, (npix + 1) / 2)
	    call sfree (sp)

	    return (median)
	}
end
