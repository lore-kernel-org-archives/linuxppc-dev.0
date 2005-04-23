Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F2E367A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 08:23:48 +1000 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHIEIKCLAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHIEIKCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <08f33e2ffa1a8f4a243cf3f95aaf9e0d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 18:23:36 -0400
To: <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 23, 2005, at 6:07 PM, Joakim Tjernlund wrote:

> Do you refer to the assembler code above or some other assembler code 
> such
> as my dcbX workaround? I once had a C version of that workaround that 
> lived
> in fault.c. Sadly it think it is gone now, not sure if I ever sent it 
> to the list.

Yes, the dcbx and anything else we may have to place in there.  At most,
we should emulate whatever is necessary in C code and just invalidate
the TLB entry for reloading, if the PTE has changed.  We shouldn't be
trying to load TLB entries.

Thanks.


	-- Dan
