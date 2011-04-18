Return-Path: <B11780@freescale.com>
Subject: Re: [PATCH 10/15] powerpc: Define slb0_limit() for BOOK3E
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1303162902.28876.164.camel@pasglop>
Date: Mon, 18 Apr 2011 17:30:50 -0500
Message-ID: <5313E556-6BFA-48D0-921F-7CF91892514A@freescale.com>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
	<DB59DA71-C6DA-4E65-9251-C29B973345AD@freescale.com>
	<1303162902.28876.164.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <michael@ozlabs.org>, Jimi Xenidis <jimix@watson.ibm.com>,
	jack@codezen.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 18, 2011, at 4:41 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2011-04-18 at 07:42 -0500, Kumar Gala wrote:
>> Let's rename this function to something 'linear_map'.  As on FSL
>> Book-E 64 we do things a bit differently and have more covered in
>> linear map than 1G
> 
> It's not quite linear_map. It's whatever can be accessed without taking
> exceptions. IE. What is bolted.
> 
> It should probably go into a variable initialized by the mm code tho.
> 
> Cheers,
> Ben.

Is this 'ppc64_rma_size' ?

- k
