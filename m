Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D29EBDDF75
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:48:35 +1100 (EST)
In-Reply-To: <20080321160802.7CED7196805C@mail103-sin.bigfish.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com><20080320144402.3063517C005D@mail148-sin.bigfish.com><fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com><18403.32257.725539.470771@cargo.ozlabs.ibm.com>
	<82ce3dbb9ebdb1fa4fc7407ed3396411@kernel.crashing.org>
	<20080321160802.7CED7196805C@mail103-sin.bigfish.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87477fcc1ac591dc6b76d84caa99ac59@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx
	uart16550.
Date: Fri, 21 Mar 2008 17:48:30 +0100
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Cc: John Linn <linnj@xilinx.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I thought about this, and reconsidered it again after I finally figured
> out how to get the Power.org website to relenquish the ePAPR spec, 
> which
> (FWIW) has reg-shift as an optional property of the ns16550 binding.
>
> However, I'm not enamoured of it, since I doubt it's really good to be
> doing ioremaps and memory management on unaligned blocks.  It seems 
> more
> logical to me to have the reg property define a range of aligned
> addresses, and in this case, it happens that the driver never touches
> some of those bytes.

Yes, and that is (part of) why "reg-offset" might be needed /
might be a good idea.

> In any event, the real point of the patch was to spark some discussion,
> which we failed to get otherwise.. :)

You succeeded :-)


Segher
