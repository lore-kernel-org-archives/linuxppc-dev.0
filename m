Message-ID: <3EFFD86B.7060007@stinkfoot.org>
Date: Mon, 30 Jun 2003 02:27:55 -0400
From: Ethan Weinstein <e-d0uble@stinkfoot.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: aic7xxx panics
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,

I've been unable to get 2.4.21-ben(1|2) to boot with my
powerdomain-39160, I get an immediate panic ("machine check in kernel
mode"). kernel.org 2.4.21 panics as well.  2.4.20-ben10 and prior
kernels boot fine off this controller, albeit connecting something to
the external ports like a tape drive causes panics, and on occasion I
get lockups and bizarre scsi behaviour with this config.
   This system is a MDD, dual G4@1.2 ghz, with 1280M of RAM, and 4
ultra160 drives attached to the 39160.
   I've posted before about this issue, and I apologize for that, I also
apologize for posting to the dev list,  but it seems as if this is an
oddball configuration that nobody seems to use.. everone's using IDE.
Perhaps this driver is just not updated for the ppc arch, or has endian
issues? Maybe the entire scsi layer for ppc has problems? I can't say.
Regardless.. I'd like to see this fixed, this is a long-standing issue.
I'd even be willing to lend or donate a powerdomain card to someone
who'd be able to fix the driver for linux-ppc... I use the same card on
several x86's with no such problems.

thanks.

Ethan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
