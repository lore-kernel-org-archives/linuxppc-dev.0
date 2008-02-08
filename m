Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 77448DDF38
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Feb 2008 06:32:15 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1054656anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Feb 2008 11:32:13 -0800 (PST)
Message-ID: <fa686aa40802081132h22b91464xd150e0671ca4fc34@mail.gmail.com>
Date: Fri, 8 Feb 2008 12:32:13 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "A. Nolson" <alohanono@gmail.com>
Subject: Re: APU FPU in Virtex ppc405
In-Reply-To: <47ACA4BB.6010903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47ACA4BB.6010903@gmail.com>
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

On Feb 8, 2008 11:51 AM, A. Nolson <alohanono@gmail.com> wrote:
> Hi,
>
>  I have just heard that Xilinx has freed the FPU module for the PPC
> architecture in EDK9.2i. WIll I be able to make it work with my
> Secretlab Linux 2.6.24rc3? Will the eldk toolchain for PPC_4xxfp work?
> Will it be just a matter of integrating it with the XPS BSP?I make an
> extensive use of floating point in my applications and this will be
> really useful.

It's been 2 years since I last played with the FPU core.  At the time
it wasn't a complete FPU so the eldk 4xxfp toolchain would not work.
I had to build my own.  I don't know if the new core is a complete
implementation.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
