Message-Id: <5.1.0.14.0.20020326094300.0250cb98@pop.gmx.de>
Date: Tue, 26 Mar 2002 09:47:15 +0800
To: boehringer@snom.de, linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Problem booting Linux on MPC8XXFADS
In-Reply-To: <3C9F67A5.827D4BBC@snom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 07:08 PM 3/25/2002 +0100, Sven Boehringer wrote:
>And i also checked the following sentences in the README:
><snip>
>Just make sure your machine specific header file (for instance
>include/asm-ppc/tqm8xx.h) includes the same definition of the Board
>Information structure as we define in include/ppcboot.h, and make
>sure that your definition of IMAP_ADDR uses the same value as your
>PPCBoot configuration in CFG_IMMR.
><snip>
>

You also have to compare the configuration of the ppcboot header file
config_FADS860.h and the mpc8xx 'make menuconfig'-configuration of the
kernel. The SMCs and SCCs are easily misconfigured.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
