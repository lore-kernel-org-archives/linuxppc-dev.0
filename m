Date: Thu, 13 Jul 2000 17:03:15 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Taylor Holliday <wtholliday@ucdavis.edu>
cc: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree 4.0.1 dual head attempt
In-Reply-To: <396D1C7B.AA6864F5@ucdavis.edu>
Message-ID: <Pine.LNX.4.21.0007131654530.2728-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Taylor Holliday wrote:

> Hi all
>
> Attached is the latest XFree86.0.log as well as the XF86Config from my
> recent build (yesterday) of 4.0.1 with the drivers rsync'ed from
> penguinppc.org. Hey, at least it doesn't crash the machine (AGP G4, 2
> r128) :-). Any suggestions on what to do or where to start debugging?
>
> - Taylor
>

  Comment out the vgaHWSave/vgaHWRestore calls in r128_driver.c and
try again (defining R128_DEBUG in r128.h will be a good idea also)

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
