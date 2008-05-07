Return-Path: <bshtein@yahoo.com>
Received: from web50611.mail.re2.yahoo.com (web50611.mail.re2.yahoo.com
	[206.190.38.157]) by ozlabs.org (Postfix) with SMTP id B98C1DDFD3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:42:55 +1000 (EST)
Date: Wed, 7 May 2008 11:42:53 -0700 (PDT)
From: Boris Shteinbock <bshtein@yahoo.com>
Subject: Re: powerpc port for sbc8260-based board problem
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <833555.65590.qm@web50611.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 07, 2008 at 01:31:52AM -0700, Boris Shteinbock wrote:
>      /* Monitor port/SMC1 */
>      smc1: serial@11a80 {
>        device_type = "serial";
>        compatible = "fsl,mpc8260-smc-uart",
>                     "fsl,cpm2-smc-uart";
>        reg = <0x11a80 0x20 0x1100 0x40>;

>The second reg resource depends on where your firmware set up the SMC pram
>regs.  With U-boot, it's usually zero.

>Note that as of 2.6.26-rc1, this is set up dynamically instead, and the
>second resource should be .
Is this correct?

        reg = <0x11a80 0x20 0x87fc 2>;

I also understand, that latest development kernel contains some significant changes in SMC UART code, especially
in muram code, is this correct? So does this reg value reflect this change?

>> Can someone, also, explain, how "fsl, cpm-command" field works,

>It's the device-specific portion of the value that gets written to the CPM
>command register (page, sub-block, and mcc channel).

Is it possible to get a quick list of all values for all 8260 soc devices somewhere ? Or do I have to dig  specific Freescale reference for it?
I am particularly interested in SMC2 and FCC1,2 and 3 ?


Thank you very much



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
