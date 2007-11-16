Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C6CADDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 09:40:01 +1100 (EST)
Date: Sat, 17 Nov 2007 01:28:37 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: benh@kernel.crashing.org
Subject: Re: [POWERPC] [RFC] Fix 8xx tlbie definition
Message-ID: <20071117012837.4811d394@kernel.crashing.org>
In-Reply-To: <1195247189.28865.174.camel@pasglop>
References: <20071116112822.37a238c0@weaponx>
	<1195247189.28865.174.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 17 Nov 2007 08:06:29 +1100
Benjamin Herrenschmidt wrote:

> 
> On Fri, 2007-11-16 at 11:28 -0600, Josh Boyer wrote:
> > Git commit e701d269aa28996f3502780951fe1b12d5d66b49 introduced an
> > incorrect definition for _tlbie on PowerPC 8xx platforms.  Only the
> > address should be passed to the function.  This patch corrects the
> > definition of _tlbie and the related tlb flushing functions for 8xx.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> That conflicts with the patch I posted to fix it differently (I kept
> the additional argument).
> 

Where can I grab it to give a try? My linuxppc archive is silent for some reason..
> Which one do we take ?
> 

If your solution will work out, I'd agree with Kumar to have this thing consistent.
If not - It might be cheapier just to fix it this gross way, to keep 8xx stuff running. 

-- 
Sincerely, Vitaly
