Date: Sun, 16 Mar 2003 17:30:26 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: mikpe@csd.uu.se
Cc: afleming@motorola.com, oprofile-list@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC750 perfmon/TAU/decrementer erratum?
Message-ID: <20030316163026.GA4496@ibrium.se>
References: <200303161510.h2GFAWhT018082@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200303161510.h2GFAWhT018082@harpo.it.uu.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 16, 2003 at 04:10:32PM +0100, mikpe@csd.uu.se wrote:
>
> Motorola's MPC750UM.pdf, section C-13 page C-78, states:
> "The performance monitor of the MPC755 functions the same as that
> of the MPC750, (...), except that for both the MPC750 and MPC755,
> no combination of the thermal assist unit, the decrementer register,
> and the performance monitor can be used at any one time. If exceptions
> for any two of these functional blocks are enabled together, multiple
> exceptions caused by any of these three blocks cause unpredictable
> results."
>
> My interpretation: Either the reference is wrong and it actually
> refers to the 745 and 755 instead of 750 and 755, or it sneaks in
> a big fat erratum for the 750 in the 745/755-specific section.
>
> Does anyone know for sure whether the 750 has this erratum or not?

The erratum is correct. Some revs of the 750 definitely have
this problem. More specifically, the 750 in my iBook exhibits
this problem but my B&W G3 does not (or perhaps it was
the B&W G3, not the iBook, that had the problem).

PVRs:
	B&W G3: 	0008 0202
	iBook:  	0008 8300

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
