Message-ID: <3A19A9EF.C43EACFC@mvista.com>
Date: Mon, 20 Nov 2000 14:47:11 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: "Ruhland, Paul" <pruhland@microwavedata.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded] PCMCIA on MBX860
References: <DF2142DFD5ECD311BA1900104B943A979321CF@roche-exg1.rochester.adaptivebroadband.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have pcmcia-cs working on the Embedded Planet boards, but I haven't
tested on a MBX. I assume that the MBX uses the builtin pcmcia
controller on the 8xx.  if that is the case, then you need the 8xx
socket driver.  It is included with the card services package starting
with verison 3.1.23.  Also I have patches on
ftp://ftp.mvista.com/Area51/ppc_8xx.  If changes are needed for the MBX,
let me know and I will get them into the 8xx socket driver.

"Ruhland, Paul" wrote:
>
> I've had zero success compiling the pcmcia-cs-3.1.19 card services package
> for an MBX860 board.
>
> Using:
>     mVista hardhat kernel 2.2.14
>     mVista hardhat cross compiler
>
> Its choking in 'modules/i82365.c' with the following error:
>
>      #error "no bus architectures defined!"
>
> From this, I figured I needed to include either PCI or ISA support in my
> kernel config.  However, enabling QSpan PCI in kernel configuration yields
> errors during kernel build.
>
> Has anyone gotten the card services to work on an MBX board?
>
> ----------------------
> Paul Ruhland
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
