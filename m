Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46713999.2080004@ru.mvista.com>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>
	<20070612044246.GC4198@localhost.localdomain>
	<46713999.2080004@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c23fca4d9242ac39f6e7afcf487d3373@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 14 Jun 2007 15:43:26 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> , and I don't see what
>> it buys us over the partitions/partition-names pair of properties.
>
>    I was thinking of using a signle multipart prop but dtc had no 
> support for it at that time...

The kernel (and probably most DTB parsers) cannot handle
unaligned integers in properties, even though it is a
perfectly fine thing to have.


Segher
