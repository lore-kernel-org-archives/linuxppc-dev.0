Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id A0C0A2BF0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 22:16:53 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i9TCHscP024809
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 15:17:55 +0300 (EEST)
Message-ID: <41823396.40001@intracom.gr>
Date: Fri, 29 Oct 2004 15:12:06 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
References: <JPEALJAFNGDDLOPNDIEEIEMNCNAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <JPEALJAFNGDDLOPNDIEEIEMNCNAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:

>>On Thu, Oct 14, 2004 at 04:53:49PM +0200, Joakim Tjernlund wrote:
>>
>>    
>>
>>>Is it not time to merge 8xx from linuxppc-2.5 into Linus tree?
>>>
>>>I know the 8xx is not fully functional yet but this isn't done
>>>soon I think it won't happen at all. The 8xx arch can be made to 
>>>depend on BROKEN in Linus tree to make it clear that it isn't
>>>working properly yet.
>>>      
>>>
>>I've been the hard-ass about holding back on moving 8xx forward.  Once
>>2.6.9 finally comes out (assuming and hoping that Linus really intends
>>to do a release and not -rc5), I'll start moving stuff over and make it
>>depend on BROKEN hopefully in time for 2.6.10-rc1.
>>
>>-- 
>>Tom Rini
>>    
>>
>
>Any progress?
>
> Jocke
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
I'm currently battling to make 2.6.10-rc1 work the same way it used do.

But something changed in slab management and the kmallocs in request_irq
called by init_IRQ fails.

2.6.9-rc1 works.

ARGHHHHHHHHHH.

Ahem.

Regards

Pantelis
