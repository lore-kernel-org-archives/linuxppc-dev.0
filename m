To: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Access to registers of MPC823E 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 17 Oct 2001 12:19:28 +0200."
             <3BCD5B30.5396ADEC@disca.upv.es>
Date: Wed, 17 Oct 2001 14:33:02 +0200
Message-Id: <20011017123307.5A40810889@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BCD5B30.5396ADEC@disca.upv.es> you wrote:
>
> I'm trying to write a program to run in Linux 2.4.4 (booting from
> PPCBoot) on a TQM823L (MPC823E), but I'm having some problems.
...
> #define CFG_IMMR 0xFFF00000
...
> When my main program tries to access to TCGR to read or write it simply
> exits out of the program without a warning into the shell.
...
>  asm( "mfspr %0,638": "=r"(immr) : );
>  printf("IMMR = %li\n", immr);
...
> Got any idea of what can be going on?

In user space you cannot  access  hardware  directly  using  physical
addresses, nor execute any priviledged istructions.

The Linux kernel protects itself from  malicious  users  who  try  to
tamper with it's internals :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The Gates in my computer are AND, OR and NOT; they are not Bill.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
