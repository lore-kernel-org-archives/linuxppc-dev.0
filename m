Return-Path: <holindho@cs.helsinki.fi>
Message-ID: <43390DDC.7090701@cs.helsinki.fi>
Date: Tue, 27 Sep 2005 12:16:12 +0300
From: Heikki Lindholm <holindho@cs.helsinki.fi>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>	<20050927082324.GA11437@lst.de>
	<17209.817.732159.375607@cargo.ozlabs.ibm.com>
In-Reply-To: <17209.817.732159.375607@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras kirjoitti:
> Christoph Hellwig writes:
> 
> 
>>What about just dropping POWER3/4 support in 32bit mode?
> 
> 
> Yes... I'm getting very close to deciding to do that.  In fact POWER3
> isn't too bad, since it still has BATs, but POWER4/PPC970 would be
> tricky.
> 
> Does anyone on these lists have any major objections if we drop
> support for 32-bit kernels on POWER3 and POWER4/PPC970?

I think it was Kumar Gala who already asked this a while ago. For me, 
32-bit kernel on a 970 has been useful "initial stage" of gradually 
porting kernel stuff over to real 64-bit, but if I'm the only user and 
keeping the support is a nuisance, go ahead and drop it.

-- Heikki Lindholm
