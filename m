Date: Thu, 25 Oct 2001 11:53:27 -0500 (CDT)
Message-Id: <200110251653.f9PGrRd19727@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: trini@kernel.crashing.org
Cc: tkoba@ike-dyn.ritsumei.ac.jp, jeglin@4pi.com,
	linuxppc-dev@lists.linuxppc.org
In-reply-to: <20011025083032.A29107@cpe-24-221-152-185.az.sprintbbd.net>
	(message from Tom Rini on Thu, 25 Oct 2001 08:30:32 -0700)
Reply-To: Ed.Swarthout@Motorola.com
Subject: Re: 2.4.13-pre5 crash when mounting proc
References: <p04330100b7f7f805ef9a@[24.163.33.28]> <20011025.233136.74750056.tkoba@ike-dyn.ritsumei.ac.jp> <20011025083032.A29107@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom wrote:
>
> Um.  Is that _all_ that changed?  That really shouldn't have any effect
> at all...  What compiler/binutils combo is this?

Well it's important for the COPY_16_BYTES_EXCODE macro to switch back to
the .text section or any following code will go in the __ex_table section!

It looks like the .text line was deleted in the 1.8 change set for linuxppc_2_4

If you notice the linuxppc_2_4_devel has two .text lines next to each other.
(I had fun debugging this same type failure when I added the .stabs lines
and left only one .text line)

-Ed

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
