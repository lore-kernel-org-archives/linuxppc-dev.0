Message-ID: <3B829C48.64C5FCDF@mvista.com>
Date: Tue, 21 Aug 2001 10:37:12 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Felix Radensky <felix@allot.com>
Cc: Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 vs RiskWatch
References: <3B8212A6.9AF31020@allot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Felix Radensky wrote:
> Can someone please explain what BDI2000 can do that RiskWatch cannot.

To me, the main thing is that it integrates well with a Linux
development box.  I use my normal debug tools (ddd/gdb) and the BDI2000
acts like a gdbserver for the kernel.  For things such as FLASHing code
into the target, you just telnet into the BDI2000.

Bottom line: If you are developing on Windows, the RiscWatch is probably
what you want.  If you are developing on Linux (which I hope is the
case), you want a BDI2000.  Otherwise, you're going to need a Windows
box for RiscWatch to run on and then you'll have to set up Samba or some
other mechanism for the Windows box/RiscWatch to see your sources, etc.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
