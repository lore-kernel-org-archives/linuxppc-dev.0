Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3D7F67C2D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 05:44:10 +1100 (EST)
In-Reply-To: <4586BA3F.5030209@freescale.com>
References: <00b001c7222f$c4d63b50$1e67a8c0@Jocke>
	<4586BA3F.5030209@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27EF3DDC-DD21-4EAA-A3F2-36FD21BA1696@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
Date: Mon, 18 Dec 2006 12:44:19 -0600
To: Timur Tabi <timur@freescale.com>
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2006, at 9:56 AM, Timur Tabi wrote:

> Joakim Tjernlund wrote:
>
>>> I've tested these on an 8360EMDS, and Kumar has reviewed and
>>> signed off on the
>>> code, so I think they're good.  Please let me know if they're not.
>>
>> Has these been sent upstream yet? Didn't se them in linux tree as  
>> of now.
>
> I posted the patches to the linuxppc-dev and netdev mailing lists.   
> At this
> point, these patches are at the whim of Paul M. and/or Jeff G. for  
> merging.
> Since the holidays are upon us, I'm not surprised that things are  
> taking longer
> than normal.

There really at the whim of Jeff G. since they are completely driver  
related.  I pinged Jeff G. to hopefully pick them up and push them  
for 2.6.20.

- k
