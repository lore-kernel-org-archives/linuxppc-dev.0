Date: Sun, 16 Mar 2003 16:10:32 +0100 (MET)
Message-Id: <200303161510.h2GFAWhT018082@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: afleming@motorola.com
Subject: MPC750 perfmon/TAU/decrementer erratum?
Cc: linuxppc-dev@lists.linuxppc.org, mikpe@csd.uu.se,
	oprofile-list@lists.sourceforge.net
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Motorola's MPC750UM.pdf, section C-13 page C-78, states:
"The performance monitor of the MPC755 functions the same as that
of the MPC750, (...), except that for both the MPC750 and MPC755,
no combination of the thermal assist unit, the decrementer register,
and the performance monitor can be used at any one time. If exceptions
for any two of these functional blocks are enabled together, multiple
exceptions caused by any of these three blocks cause unpredictable
results."

My interpretation: Either the reference is wrong and it actually
refers to the 745 and 755 instead of 750 and 755, or it sneaks in
a big fat erratum for the 750 in the 745/755-specific section.

Does anyone know for sure whether the 750 has this erratum or not?

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
