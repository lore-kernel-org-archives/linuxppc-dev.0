To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Definitions for c_cflag etc. in termbits.h??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Jan 2003 16:09:51 +0100."
             <3E1EE23F.5BC310F3@imc-berlin.de>
Date: Fri, 10 Jan 2003 16:25:32 +0100
Message-Id: <20030110152537.663E4C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steven,

in message <3E1EE23F.5BC310F3@imc-berlin.de> you wrote:
>
> E.g. the DEFINEs of c_iflags appear to me as decimal values!?
>
> /* c_iflag bits */
> #define IGNBRK  0000001
> #define BRKINT  0000002
> #define IGNPAR  0000004
> #define PARMRK  0000010
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

No, these are octal values, of course.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
