Message-Id: <5.0.2.1.2.20010302124631.01aabdf0@mail.munich.netsurf.de>
Date: Fri, 02 Mar 2001 13:07:10 +0100
To: Stephen Turner <sret1@cam.ac.uk>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: Bug#86356: analog: analog segfaults
Cc: 86356@bugs.debian.org,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	Andrew Sharp <andy@netfall.com>, "Marco d'Itri" <md@Linux.IT>,
	Michel Lanners <mlan@cpu.lu>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96.1010302101639.19312B-100000@gamma.statslab.c
 am.ac.uk>
References: <01022318305301.06077@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:29 02.03.2001, Stephen Turner wrote:

>This turns out to be a bug in gcc, not analog. On ppc, gcc 2.95.2 seems to
>have alignment problems when a function is passed certain long lists of
>arguments including doubles. But apparently the bug is fixed in the (not yet
>released) 2.95.3 version of gcc.

No, it won't be fixed in the official gcc-2.95.3, cause the release manager
Bernd Schmidt rejected my patch because of the possible implications for
other platforms. It is fixed in my Linux/PPC RPM's since about a year, and
accordingly in the update RPM's for LinuxPPC and YDL. Suse is fixed too, I
think since around mid-last-year. Somehow Debian slipped through, but I
have been in contact with Daniel Jacobowitz, and I think he will upgrade
the Debian package soon (or he already has?).
My current diff against the GCC CVS gcc-2_95-branch (which will become the
official 2.95.3) can be found at
<ftp://devel.linuxppc.org:21/users/fsirl/cvs-2_95-branch-ppc.diff>, I just
updated it with a fix for the loop bug uncovered by some MPEG player.

gcc-3.0pre (PPC RPM's soon to come) already has all the fixes, so with 3.0
we all will be in sync again.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
