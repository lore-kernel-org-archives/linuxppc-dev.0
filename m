Date: Mon, 25 Nov 2002 16:09:06 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: caixupeng <edmoon@huawei.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot, linux , hang  at the last step
In-Reply-To: <000d01c29471$ca5b94d0$92690b0a@DBKQW41X>
Message-ID: <Pine.LNX.4.40.0211251608140.14353-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 25 Nov 2002, caixupeng wrote:

> VFS: Cannot open root device "" or 16:01
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 16:01
>
> I have set the "bootargs=root=/dev/ram"

Try "setenv bootargs root=/dev/ram0 rw" in ppcboot.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
