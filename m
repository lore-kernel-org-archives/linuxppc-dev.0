Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D55CDDF5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 00:33:28 +1000 (EST)
Subject: Re: Broadcom HT1000/HT2000 or HT1100 support in IBM PowerPC 970MP/Fx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ashok Hegde <AshokHegde@solectron.com>
In-Reply-To: <52C5E6AE59DB984B9ECCBCADFE1C5E15050DABBB@BNGWNEXC0001.bng.slr.com>
References: <52C5E6AE59DB984B9ECCBCADFE1C5E15050DABBB@BNGWNEXC0001.bng.slr.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 16:33:22 +0200
Message-Id: <1188225202.5972.65.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Mon, 2007-08-27 at 19:36 +0530, Ashok Hegde wrote:
> Hi All,
> 
>  
> 
> Is any of these broadcom HT1000/HT2000/HT1100 chipsets supported with
> IBM 970MP/FX?
> 
> Could please anyone provide me the Linux kernel link for product with
> this combination (IBM 970MP/FX + HT1000/HT2000/HT1100)?

You can't plug one of these directly onto a 970, you need a northbridge
first, such as IBM CPC945 :-) But then, yes, those work fine behind that
bridge. Apple and IBM both used these on 970 + CPC945/U4 based products.

Ben.
