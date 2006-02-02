Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3B6FF68A72
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 01:08:01 +1100 (EST)
Date: Thu, 2 Feb 2006 17:07:53 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: Accessing the CPM2 on an MPC82xx : CPM_MAP_ADDR or cpm2_immr ?
Message-ID: <20060202170753.2a805189@vitb.ru.mvista.com>
In-Reply-To: <200602021458.26623.laurent.pinchart@tbox.biz>
References: <200602021458.26623.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2 Feb 2006 14:58:26 +0100
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi everybody,
> 
> I noticed that the CPM2 module is accessed both through CPM_MAP_ADDR (physical 
> address) and cpm2_immr (ioremap()ed address). For instance, the fec_enet 
> driver configures the IO ports using (cpm2_map_t*)CPM_MAP_ADDR.
> 

Mentioned driver is deprecated. 
> What's the correct way to access the CPM2 module ? Does ioremap() map 
> CPM_MAP_ADDR to itself so that both ways are correct ?
> 

Even direct cpm2_immr usage is not a good thing, but I cannot tell more without knowing your concerns. Can you please describe what you are planning to implement, prolly we can advice how to do that proper way.


> Laurent Pinchart
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
