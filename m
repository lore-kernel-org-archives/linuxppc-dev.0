Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 97EA3679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 01:53:17 +1000 (EST)
In-Reply-To: <c8a775fb36a415f9b45ed713e4c63caa@onz.com>
References: <c8a775fb36a415f9b45ed713e4c63caa@onz.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e763199be1cca62d14cf4d0011b5f6e0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 16 Jun 2005 10:53:07 -0500
To: "Allen Curtis" <acurtis@onz.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> So have we answered your question regarding the inclusion of DMA and
> CPM in the platform_device array? If I am reading this correctly, all
> the individual CPM "objects" should be defined in the device structure
> with their physical address location defined. The complete IMMAP
> structure can then be constructed from these objects if required.

Actually, I dont feel that anyone has given a reason why or how they 
would use CPM, DMA, SI1, SI2 if they were platform devices.

> Is it possible to add some flags to the IORESOURCE information to
> address the differences in SCC structures between processor types?
> Perhaps something like this could be used to apply the correct
> structure cast in the device driver. Just a thought...

I envisioned this being a field in the platform_data structures for the 
devices.

- kumar
