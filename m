Subject: RE: BDI2000 vs RiskWatch
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 21 Aug 2001 13:44:18 -0400
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49750C3E0@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Scott Anderson" <scott_anderson@mvista.com>,
	"Felix Radensky" <felix@allot.com>
Cc: "Linix PPC Emmbedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


IBM only supplies programs to run the RISCWatch on Windows,
RS/6000, and Sun (no Linux).  As an alternative to buying a
separate box, you can also run the Windows version of the
software under VMware on Linux.  You still have the "access
to sources" problem, though.

  -- David Wright, InfiniSwitch Corp.



> -----Original Message-----
> From: Scott Anderson [mailto:scott_anderson@mvista.com]

> Felix Radensky wrote:
> > Can someone please explain what BDI2000 can do that
> > RiskWatch cannot.
>
> To me, the main thing is that it integrates well with a Linux
> development box.  I use my normal debug tools (ddd/gdb) and
> the BDI2000
> acts like a gdbserver for the kernel.  For things such as
> FLASHing code into the target, you just telnet into the BDI2000.
>
> Bottom line: If you are developing on Windows, the RiscWatch
> is probably
> what you want.  If you are developing on Linux (which I hope is the
> case), you want a BDI2000.  Otherwise, you're going to need a Windows
> box for RiscWatch to run on and then you'll have to set up
> Samba or some
> other mechanism for the Windows box/RiscWatch to see your
> sources, etc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
