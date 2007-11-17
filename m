Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBB92DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 12:05:57 +1100 (EST)
Subject: Re: [POWERPC] [RFC] Fix 8xx tlbie definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20071117012837.4811d394@kernel.crashing.org>
References: <20071116112822.37a238c0@weaponx>
	<1195247189.28865.174.camel@pasglop>
	<20071117012837.4811d394@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 12:05:47 +1100
Message-Id: <1195261547.28865.184.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-11-17 at 01:28 +0300, Vitaly Bordug wrote:
> On Sat, 17 Nov 2007 08:06:29 +1100
> Benjamin Herrenschmidt wrote:
> 
> > 
> > On Fri, 2007-11-16 at 11:28 -0600, Josh Boyer wrote:
> > > Git commit e701d269aa28996f3502780951fe1b12d5d66b49 introduced an
> > > incorrect definition for _tlbie on PowerPC 8xx platforms.  Only the
> > > address should be passed to the function.  This patch corrects the
> > > definition of _tlbie and the related tlb flushing functions for 8xx.
> > > 
> > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > 
> > That conflicts with the patch I posted to fix it differently (I kept
> > the additional argument).
> > 
> 
> Where can I grab it to give a try? My linuxppc archive is silent for some reason..

Looks like I may have failed to post it ... weird, I was sure I posted
that days ago, when Olof first mentioned the breakage. I'll check &
resend.

> > Which one do we take ?
> > 
> 
> If your solution will work out, I'd agree with Kumar to have this thing consistent.
> If not - It might be cheapier just to fix it this gross way, to keep 8xx stuff running. 

Ben.
