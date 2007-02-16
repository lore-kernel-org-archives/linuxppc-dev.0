Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE19CDDEC4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 04:01:09 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BEA4@az33exm25.fsl.freescale.net>
References: <c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
	<20070215230134.GB21654@localhost.localdomain>
	<1171584519.5644.60.camel@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BEA4@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E4EC52C-CF08-46EE-8A83-5FC1ED21C5EB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: deleteboot-cpu
	and chosen nodes from all DTSfiles)
Date: Fri, 16 Feb 2007 11:00:04 -0600
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 16, 2007, at 10:58 AM, Yoder Stuart-B08248 wrote:

>
>
>> -----Original Message-----
>> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
>> Sent: Thursday, February 15, 2007 6:09 PM
>> To: David Gibson
>> Cc: Yoder Stuart-B08248; Segher Boessenkool; linuxppc-dev@ozlabs.org
>> Subject: Re: purpose of /chosen node (was RE: [PATCH]
>> powerpc: deleteboot-cpu and chosen nodes from all DTSfiles)
>>
>>
>>> You're right.  Question is, can we change it now.  It's out there in
>>> the documentation, on the other hand, I don't think the kernel
>>> actually uses it anywhere yet.  BenH, opinion?
>>
>> We can change the documentation and add a little note about  
>> "obsoleted
>> practice". I don't think the kernel uses it.
>>
>
> I'll submit a patch to booting-without-of.txt for this.

Need to also update dtc not to "warn" about it.

- k
