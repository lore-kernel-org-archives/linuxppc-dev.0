Message-ID: <20040128061326.19345.qmail@web11003.mail.yahoo.com>
Date: Tue, 27 Jan 2004 22:13:26 -0800 (PST)
From: Xupei Liang <tliang@yahoo.com>
Subject: IDE status timeout
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a customed board that is running Linux 2.4.19
and XFS and that has a compactFlash card. The
compactFlash card is running in true IDE mode. I ran
into the following error once in a while. It is very
difficult to reproduce.

>hda: status timeout: status=0xd0 { Busy }
>hda: no DRQ after issuing WRITE
>ide0: reset timed-out, status=0x80
>hda: status timeout: status=0x80 { Busy }
>hda: drive not ready for command
>ide0: reset timed-out, status=0x80
>end_request: I/O error, dev 03:02 (hda), sector 71472

>end_request: I/O error, dev 03:02 (hda), sector 71480

>end_request: I/O error, dev 03:02 (hda), sector 77264

>end_request: I/O error, dev 03:02 (hda), sector 77272

>end_request: I/O error, dev 03:02 (hda), sector
115537
>I/O error in filesystem ("ide0(3,2)") meta-data dev
0x302 block 0x1c351
>

I read some discussions on a similar (or same?)
problem in another forum.

http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/index.html#1111

But my problem seems to be different because even a
soft reset can not reset the card and the problem
happens very randomly. The compactFlash card seems to
be stuck. Has anybody seen this problem before?

Thank you in advanced for your input.

Regards,

Terry Liang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
