Message-ID: <20001031212930.13627.qmail@web5205.mail.yahoo.com>
Date: Tue, 31 Oct 2000 13:29:30 -0800 (PST)
From: Yiran Duan <yiranduan@yahoo.com>
Subject: Any web browser for MBX
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Is there any web browser which can work on MBX board?

I have tried to build w3m with Monta Vista CDK (1.2)
stuff, but got the following error:

#File in wrong format: failed to merge target specific
data of file gc/gc.a(new_hblk.o)
#/usr/local/crossdev/powerpc-linux/bin/ld: dbg_mlc.o:
compiled for a little endian system and target is big
endian

So I think w3m can not work with PowerPC. Then I tried
lynx, but it need ncurses. I have succeeded to compile
ncurses. But when I tried to install it, I got the
following error:

#../progs/tic: cannot execute binary file

I know it is because the "tic" is powerpc version, but
I can not understand why it is needed in install
process.

Anyway, I just want to get a web browser run on MBX.
Could anyone give me some advice?

Thank you.
Yiran.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
