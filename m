Date: Mon, 17 Apr 2000 16:15:03 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: PRAMBoot Selector - update
To: Joseph Garcia <jpgarcia@execpc.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Message-id: <38FB9AF7.4E541642@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <38E6B0BF.1A3FECC5@execpc.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Garcia wrote:

> I spend some time with different devices on my powerbook, found there were some
> huge gaps in the code i released.  I have released an update, and this time it
> should work much better, and make more sense.  I think I have decoded the
> meaning to the extent of how it effects my powerbook.  Changes can be made to
> the boot selections by editing the .h file.
>
> can be gotten at http://www.execpc.com/~jpgarcia
>
> Any feedback/updates welcome.  Im more concerned with correctness than the
> interface.  Next, I plan on implementing a partition map scan to find all
> possible bootables, like MacOS does, but have little idea yet on how to do it.
>
> --
> Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
> CS Undergraduate                      Student Employee - Systems Programmer
> University of Wisconsin - Madison                            UW Lidar Group
>

I'm having a small problem wit h SetPRAMBoot.  This is most likely an error on my
part (doh!).  I used it to set the boot PRAM so I could boot back to macos.  The
values I used were 2 0 0 9.  I'm thinking this is /dev/hda9.  Is this incorrect?
Anyways,  I tried to use the zap-PRAM keys to reset the thing, but it doesn't
recognize that I'm holding them down, and just boots directly back to linux.
Tried to boot from a cd, computer ignores that I'm holding C down.  System is a
Pismo Powerbook, Linux PPC 2000, with Ben's 2.2.15-pre14 kernel.  Any ideas?

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
