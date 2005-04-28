Return-Path: <peter.ryser@xilinx.com>
Received: from mail66-res-R.bigfish.com (mail-res.bigfish.com [63.161.60.61])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B706167B22
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 00:40:01 +1000 (EST)
Message-ID: <4270F04E.9010305@xilinx.com>
Date: Thu, 28 Apr 2005 07:16:46 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: "Peter 'p2' De Schrijver" <p2@mind.be>
References: <20050428094716.GA17582@mind.be>
In-Reply-To: <20050428094716.GA17582@mind.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: connecting BDI2000 to ML403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If your debugger needs nTRST and HALT you can route the JTAG signals of 
the PPC405 processor through user IO pins to the expansion connector.

- Peter


Peter 'p2' De Schrijver wrote:

>Hi,
>
>I'm trying to figure out how to connect the BDI 2000 with a Xilinx ML403 
>development board. As far as I can see in the ML403 schematics, the JTAG
>connector lacks the nTRST and the HALT signals needed for JTAG
>debugging. Any ideas ?
>
>Thanks,
>
>Peter (p2).
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
