Date: Wed, 28 Jul 1999 13:05:39 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Motorola Web Site 
In-Reply-To: <199907281336.PAA20067@denx.muc.de>
Message-ID: <Pine.LNX.4.10.9907281254550.30083-100000@fwrsl-11.phx.mcd.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jul 1999, Wolfgang Denk wrote:
> In message <m119OXL-0000WZC@tri-yann.crf.canon.fr> you write:

<snip things that jpeters can respond to>

> 3) Is Motorola going to extend it's Linux support to the embedded controllers
>    (MPC8xx, MPX82xx) ?

I'm not speaking for Motorola Computer Group, but the idea is to support
all current systems under Linux.  For MPC8xx and  MPC82xx processors,
this means the MBX (8xx) and the announced MVME2100 (82xx).

Keep in mind that the various evaluation boards for 8xx and 82xx are
produced by Motorola Semiconductor Processor Sector and any support for
those products would have to come from them.  I can tell you I have zero
contact with them and don't even know if they can pronounce Linux. :)

> 4) Running a diff against the original 2.2.10 distribution results in
>    *all* files  being  different;  why  were  all  the  $Id$  strings
>    changed?

The patch creator forgot the -kk option in cvs to ignore tag changes.  I
passed this on...

--
Matt Porter                                       Motorola Computer Group
matt_porter@mcg.mot.com                           CIBU Linux Support


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
