Message-ID: <20040514150316.61675.qmail@web15207.mail.bjs.yahoo.com>
Date: Fri, 14 May 2004 23:03:16 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: RPX-CLLF porting
To: Prabhakar Kalasani <kalasani@sena.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <ACEDKFIMODAHBNCONGOHGEOFCDAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prabhakar Kalasani <kalasani@sena.com> wrote:
> I have got RPX-CLLF target , I'm trying to port PPC Linux , I made
> tftp,nfs and DHCP setup and I could able to load the kernel using tftp
> , the problem is I couldn't able to run the kernel .

> File                                           =
> vmlinux
> ENET                                           =
> 0010EC002D1E
> DefaultENET                                    =
> ENET
> TftpRAM                                        =
> High
> Start                                          =
> 400000
> Format                                         =
> NetBin

> Enter server filename   <vmlinux> :
> Enter (B)inary or (S)record input mode <B> :
> Enter address offset  : <00400000 hex> :
> .512.1024..2048...
> Total bytes = 1839078 in 9948811 uSecs

Pls check your LINUX kernel format.As you set in the
configuation,image format is NetBin.But it seemed that
you downloaded ELF kernel.Pls try zImage.embedded
rather than vmlinux.

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
