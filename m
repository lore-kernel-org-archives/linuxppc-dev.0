Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <5725AF6EE9FAD51195DC009027E3770201266556@az33exm35.corp.mot.com>
From: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Definitions for c_cflag etc. in termbits.h???
Date: Fri, 10 Jan 2003 08:18:41 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2B8BB.5A3C63DC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2B8BB.5A3C63DC
Content-Type: text/plain



> -----Original Message-----
> From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
> Sent: Friday, January 10, 2003 9:10 AM
> To: LinuxPPC
> Subject: Definitions for c_cflag etc. in termbits.h???
>
>
>
> Hi there,
>
> I am playing around with UARTs and got completly confused
> when looking at
> ./include/asm-ppc/termbits.h:
>
> E.g. the DEFINEs of c_iflags appear to me as decimal values!?
>
> /* c_iflag bits */
> #define IGNBRK  0000001
> #define BRKINT  0000002
> #define IGNPAR  0000004
> #define PARMRK  0000010


It's octal, and the values are the same.  Octal 10 = Hex 8.
As to why octal, I couldn't hazard a guess...



> #define INPCK   0000020
> #define ISTRIP  0000040
> #define INLCR   0000100
> #define IGNCR   0000200
> #define ICRNL   0000400
> #define IXON    0001000
> #define IXOFF   0002000
> #define IXANY   0004000
> #define IUCLC   0010000
> #define IMAXBEL 0020000
>
> So how could code like
>
> ./arch/ppc/8xx_io/uart.c:       if (I_BRKINT(info->tty) ||
> I_PARMRK(info->tty))
> or
> ./arch/ppc/8xx_io/uart.c:#define RELEVANT_IFLAG(iflag) (iflag &
> (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
>
> possibly work?
>
> Shouldn't that be hex values as in ./include/asm-sparc64/termbits.h:
>
> /* c_iflag bits */
> #define IGNBRK  0x00000001
> #define BRKINT  0x00000002
> #define IGNPAR  0x00000004
> #define PARMRK  0x00000008
> #define INPCK   0x00000010
> #define ISTRIP  0x00000020
> #define INLCR   0x00000040
> #define IGNCR   0x00000080
> etc. ???
>
> Thanks,
>
> Steven
>


------_=_NextPart_000_01C2B8BB.5A3C63DC
Content-Type: application/octet-stream;
	name="Gary Milliorn (E-mail).vcf"
Content-Disposition: attachment;
	filename="Gary Milliorn (E-mail).vcf"

BEGIN:VCARD
VERSION:2.1
N:Milliorn;Gary
FN:Milliorn Gary-rxcr80
ORG:10060985;SD646
TEL;WORK;VOICE:5129667066
ADR;WORK;ENCODING=QUOTED-PRINTABLE:;TX32/PL44;MOTOROLA INC.=0D=0A7700 W. PARMER LANE;AUSTIN;TEXAS;78729;UNITED =
STATES
LABEL;WORK;ENCODING=QUOTED-PRINTABLE:TX32/PL44=0D=0AMOTOROLA INC.=0D=0A7700 W. PARMER LANE=0D=0AAUSTIN, TEXAS 787=
29=0D=0AUNITED STATES
EMAIL;PREF;INTERNET:Gary.Milliorn@motorola.com
REV:20021104T215429Z
END:VCARD

------_=_NextPart_000_01C2B8BB.5A3C63DC--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
