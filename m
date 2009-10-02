Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 886FCB7BCF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 02:41:36 +1000 (EST)
Subject: Re: Is volatile always verboten for FSL QE structures?
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4AC61247.1030507@freescale.com>
Date: Fri, 2 Oct 2009 11:41:28 -0500
Message-Id: <C3FE6281-04FA-48B3-96EA-D6E68AF65D6B@kernel.crashing.org>
References: <4AC60AD8.8030509@ruggedcom.com> <4AC61247.1030507@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Michael Barkowski <michaelbarkowski@ruggedcom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 2, 2009, at 9:46 AM, Timur Tabi wrote:

> Michael Barkowski wrote:
>> Just wondering - is there a case where using volatile for UCC  
>> parameter RAM for example will not work, or is the use of I/O  
>> accessors everywhere an attempt to be portable to other  
>> architectures?
>
> 'volatile' just doesn't really do what you think it should do.  The  
> PowerPC architecture is too complicated w.r.t. ordering of reads and  
> writes.  In other words, you can't trust it.
>
> No one should be using 'volatile' to access I/O registers.

See Documentation/volatile-considered-harmful.txt

- k
