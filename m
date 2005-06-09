Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3233B67B1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 19:06:59 +1000 (EST)
Date: Thu, 9 Jun 2005 10:06:40 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Pantelis Antoniou <panto@intracom.gr>
Message-Id: <20050609100640.1e79900d.ajz@cambridgebroadband.com>
In-Reply-To: <42A7DE75.8040205@intracom.gr>
References: <20050608102938.023f271f.ajz@cambridgebroadband.com>
	<d32482ab845e745a00426671eff86b9e@embeddededge.com>
	<42A7DE75.8040205@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: consistent_alloc() on 82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 09 Jun 2005 09:15:17 +0300
Pantelis Antoniou <panto@intracom.gr> wrote:

> Dan Malek wrote:
> > 
> > On Jun 8, 2005, at 5:29 AM, Alex Zeffertt wrote:
> > 
> >> Does anybody know why it isn't built for 6xx cores?
> > 
> > 
> > Because 6xx cores are cache coherent and there shouldn't
> > be any need for "uncached" memory regions.
> > 
> >> I'm working on the ATM driver and it seems that certain external
> >memory> areas accessed by the PQII CPM by-pass the cache.
> > 
> > 
> > That's news to me, and I've written lots of CPM drivers, including
> > ATM. Do you have a specific example?
> > 
> 
> I may also need consistent_alloc for some testing reasons Dan. :)
> 
> > Thanks.
> > 
> >     -- Dan
> > 
> 
> If I build arch/ppc/mm/cachemap.c will it work for 82xx? Any reason
> not to?
> 

Hi Pantelis,

I tried this in an attempt to work around my problem of the CPM
bypassing the cache but it didn't work for me....

Alex
