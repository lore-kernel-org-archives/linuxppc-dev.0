Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id AA76267B6E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 09:49:09 +1000 (EST)
Date: Sat, 19 Aug 2006 01:49:30 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux1394-devel@lists.sourceforge.net
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060818234930.GB2662@localhost>
References: <20060817230347.GC3440@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060817230347.GC3440@localhost>
Cc: linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2006 at 01:03:47AM +0200, Wolfgang Pfeiffer wrote:
> Hi All
> 
> Short version first:
> 
> The SCSI/FW routines seem to work like a charm with a LSILogic Model/
> SYM13FW500-Disk on my old Macintosh titanium-IV laptop, with exactly
> the same relatively fresh git-kernel that does not work on the
> PowerBook5,8.  That is I compiled the kernel on the Apple Powerbook5,8
> and installed it on both machines.
> 

   [ ... ]

In the meantime I suspect a hardware problem.

Here's why:

I connected the FW disk I was reporting about in previous postings to
both an older Apple titanium Powerbook and to the newer Apple alubook
5,8.

In both instances I rebooted the machines with the accompanying
different Apple OS X install CD's. Both CD's have a so-called "Disk
Utility" tool with them, a tool that generally detects and repairs
disks. The tool clearly detected the FW disk attached to my old
titanium. And the same tool didn't detect the same FW disk on the
newer alubook 5,8 ... :)

In both instances I connected the FW disk to the FW 400 connector of
the machines.

So unless there are differing FW 400 versions available on both
machines I'd suspect a hardware prob with the 5,8.

[Note: Do there actually exist different Firewire 400 versions?]

I'll make this issue clear next week with a trip to the shop where I
bought the alubook.

And I'll be back as soon as I know more ...

Thanks. And sorry the idea with the check via OSX didn't come to my
mind earlier ...

Until then, and a nice week-end to everyone

Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
