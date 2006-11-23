Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3ED3B67BE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Nov 2006 10:00:58 +1100 (EST)
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Perl 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 23 Nov 2006 08:26:36 +0100."
	<200611230826.36163.matthias.fuchs@esd-electronics.com>
Date: Fri, 24 Nov 2006 00:00:56 +0100
Sender: wd@denx.de
Message-Id: <20061123230056.464AB353B52@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200611230826.36163.matthias.fuchs@esd-electronics.com> you wrote:
> 
> there's a quick'n'dirty way to get a perl running on your CPU.
> Take the Fedora Core 4 ppc binary rpm (perl-5.8.6-15.ppc.rpm) and install it 
> from an ELDK 4 root filesystem:

This will only work if you are running on a system where your CPU has
a full-blown CPU,  32  bytes  cache  line  size,  and  your  run-time
environment (all system libraries) are configured to use the FPU.

It will fail on  FPU-less  or  FPU-restricted  systems  like  MPC8xx,
PPC4xx, or MPC85xx.

> Note: This test has been done on a PPC405. But do not forget to use a kernel 
> with math emulation for this to work. 

I guess you didn't do much testing. You should try some  mathematics,
and  you  might  be surprised what happens when your Perl binary uses
the (emulated) FPU, while the system libraries use soft-float.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's all Klatchian to me.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_
