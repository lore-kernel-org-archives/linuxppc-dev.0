Date: Tue, 22 Apr 2003 08:21:42 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux Login Fails
In-Reply-To: <008801c30875$1f7960b0$370da8c0@aman>
Message-ID: <Pine.LNX.4.52.0304220819310.1616@mag.devdep.sysgo.de>
References: <008801c30875$1f7960b0$370da8c0@aman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 22 Apr 2003, Aman wrote:

> I am using IBM PPC 440 processor. I am downloading a linux image with
> ramdisk. After the linux image comes up , I get login prompt like this
> <none> login:
> If I try to login with root, it waits for some time and again display the
> same
> <none> login:
> Am I missisng some files in the ramdisk.

Did you set up /etc/securetty?

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
