From: "Prabhakar Kalasani" <kalasani@sena.com>
To: "Song Sam" <samlinuxppc@yahoo.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: RPX-CLLF porting
Date: Wed, 19 May 2004 10:34:23 +0900
Message-ID: <ACEDKFIMODAHBNCONGOHGEPPCDAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20040514150316.61675.qmail@web15207.mail.bjs.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you  sam
I made Binary Image and I could boot my target.

Rgards,
KP

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Song Sam
Sent: Saturday, May 15, 2004 12:03 AM
To: Prabhakar Kalasani; linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPX-CLLF porting



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
