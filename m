Message-Id: <v03130308b3ec440550d3@[192.168.1.1]>
In-Reply-To: <199908270917.LAA04250@lxp03.cern.ch>
References: <v03130327b3ebecbebbd3@[192.168.1.1]>
 <v03130327b3ebecbebbd3@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 27 Aug 1999 08:41:29 -0500
To: Jes Sorensen <Jes.Sorensen@cern.ch>
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: mac-2.3.14.diff: adb
Cc: linux-mac68k@mac.linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>>> "David" == David D Kilzer <ddkilzer@computer.org> writes:
>
>David> Hi Jes, Patch description:
>
>David> ADB merge with PowerPC.  These are the m68k patches that need to
>David> be updated.  Joshua Thompson has already sent the PPC patches to
>David> that group.
>
>David> NEW FILES: arch/m68k/mac/misc.c drivers/macintosh/adb-iop.c
>David> drivers/macintosh/via-macii.c include/asm-m68k/adb_iop.h

Jes Sorensen <Jes.Sorensen@cern.ch> wrote:

>Do not belong here, create a drivers/adb if you need it - stop putting
>things in drivers/macintosh.

Well, drivers/macintosh is PPC ADB code.  If drivers/macintosh shouldn't
exist, then shouldn't it be changed or moved at a higher level?

In reality, there is some ADB mouse code in drivers/char, too, so I wonder
if drivers/char/adb would make more/less sense than drivers/adb?

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
