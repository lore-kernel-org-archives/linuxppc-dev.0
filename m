Return-Path: <kumar.gala@freescale.com>
Received: from motgate5.mot.com (motgate5.mot.com [144.189.100.105])
	by ozlabs.org (Postfix) with ESMTP id 319372BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Dec 2004 05:40:00 +1100 (EST)
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F204912B38@FTWMLVEM03.e2k.ad.ge.com>
References: <45ABD2373C33C4459D42B40EC4F346F204912B38@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <35B36824-47B6-11D9-8BFE-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 6 Dec 2004 12:39:49 -0600
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX MMU
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The TS provides an additional bit of address space on Book-E processors 
(440, e500, etc).  An exception automatically clears the MSR[IS, DS] 
fields which are used to compare against the TLB's TS field.

It was the case at one point in time (may still be) that on 440, the 
interrupt context was TS = 0, everything else was TS = 1.  Matt was 
going to (or may have) changed it so everything is TS = 0 so we could 
save a few TLB entries.

- kumar

On Dec 6, 2004, at 12:23 PM, Barbier, Renaud ((GE Infrastructure)) 
wrote:

>
>
> can someone explain to me the purpose of the TS bit in the 440GX TLBs?
>
> In the 440GX BSP, what is the point to map twice memory offset 0 (once 
> with TS=0 and once with TS=1).
>  Is that for context switch?
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
