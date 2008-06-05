Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 592AEDDF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 14:59:38 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: FP and signal 4
Date: Thu, 5 Jun 2008 06:59:30 +0200
References: <BAY101-W2A5F2B80B271BD10DE9BBBEB50@phx.gbl>
	<20080604213123.4e53f813@zod.rchland.ibm.com>
In-Reply-To: <20080604213123.4e53f813@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806050659.30499.sr@denx.de>
Cc: - Reyneke <reynekejunk@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 05 June 2008, Josh Boyer wrote:
> > Has anyone come across any floating point issues in the new powerpc
> > kernel branch with regards to 44x? I'm seeing programs (i.e.
> > init/busybox) generating signal 4 (illegal instruction) exceptions. If I
> > compile a 2.6.25 kernel with the CONFIG_MATH_EMULATION option set, then
> > everything works OK.
>
> I've not seen that.
>
> > Using a 440EPx (has a onchip FPU) with the ELDK 4.0 ppc_4xxFP toolchain
> > for all apps/kernel/fs.
>
> 440EPx should get the FPU enabled at runtime.  We use a virtual PVR to
> do the APU/FPU init.  What does your cpu node look like in your DTS
> file for your board?

And please use the dtc "-b 0" option for creating the dtb file. Without it the 
virtual PVR setup doesn't work.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
