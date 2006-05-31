Return-Path: <aidan@nicta.com.au>
Received: from mail09.syd.optusnet.com.au (mail09.syd.optusnet.com.au
	[211.29.132.190])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E4EB67A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 08:22:33 +1000 (EST)
Message-ID: <447E1725.4010908@nicta.com.au>
Date: Thu, 01 Jun 2006 08:22:29 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
References: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

Anantharaman Chetan-W16155 wrote:
> Has anyone successfully ported a Linux 2.4 Kernel on a Xilinx Virtex-4 
> FX series FPGA’s, PPC405 processor?
> 

Yes, see 
http://ozlabs.org/pipermail/linuxppc-embedded/2006-April/022583.html

Note that there are silicon bugs that prevent caches being used in some 
chips.

> More specifically, the FX100 FPGA?

I don't have one of those, sorry.

- aidan
