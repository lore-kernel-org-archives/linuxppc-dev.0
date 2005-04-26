Return-Path: <eddy.petrisor@gmail.com>
Received: from localhost.localdomain (unknown [81.181.70.10])
	by ozlabs.org (Postfix) with ESMTP id 713F267B1E
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 10:39:34 +1000 (EST)
Message-ID: <426D8A32.8090005@gmail.com>
Date: Tue, 26 Apr 2005 03:24:18 +0300
From: Eddy Petrisor <eddy.petrisor@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1114228279.5996.44.camel@gaston> <426C17D3.7000807@gmail.com>
In-Reply-To: <426C17D3.7000807@gmail.com>
Content-Type: text/plain; charset=x-user-defined; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] ppc32: Fix a sleep issues on some laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I had soem mail problems and this mail was not sent

Eddy Petrisor wrote:
> Benjamin Herrenschmidt wrote:
> 
>> Hi !
>>
>> Some earlier models of aluminium powerbooks and ibook G4s have a clock
>> chip that requires some tweaking before and after sleep. It seems that
>> without that magic incantation to disable and re-enable clock spreading,
>> RAM isn't properly refreshed during sleep. This fixes it.
> 
> over which version of kernel does this apply, or where can we find it, 
> already included? I had some problems with sleeping (well, not me, my 
> powerbook :o)
> 


-- 
Regards,
EddyP
===========================
I had a favourite quote, but I forgot it. And it was insightful.
