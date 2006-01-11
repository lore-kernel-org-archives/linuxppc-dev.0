Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <17348.50913.414568.263736@cargo.ozlabs.ibm.com>
References: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
	<17348.37558.434652.697604@cargo.ozlabs.ibm.com>
	<20060111071032.GA28843@gate.ebshome.net>
	<17348.50913.414568.263736@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C056E42C-4362-4020-8097-E8662017A27A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 11 Jan 2006 08:43:04 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>
Subject: Re: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

This reminds me do we have a bit for having/not having the load/store  
string instructions. If memory serves me there were some discussions  
of looking at "depreciating" the instructions from the architecture.  
Freescale Book-E implementations already do NOT implement them. I  
doubt that Freescale will over implement these instructions ever again.

-k

On Jan 11, 2006, at 2:50 AM, Paul Mackerras wrote:

> Eugene Surovegin writes:
>
>> I checked 44x user manuals I have:
>>
>> 440GP doesn't have isel
>> 440GX, 440EP, 440SP, 440SPe, 440GR have it.
>
> Thanks, that's helpful.  Do you know if 440{GX,EP,SP,SPe,GR} implement
> all of the 32-bit user-mode instructions in Book E?
>
> How do mbar and msync work on those processors?  As mbar and msync (as
> defined in Book E) or as eieio and sync?
>
> Do the 440* processors in fact claim Book E compliance?
>
> Thanks,
> Paul.
> _______________________________________________
> Linuxppc64-dev mailing list
> Linuxppc64-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc64-dev
