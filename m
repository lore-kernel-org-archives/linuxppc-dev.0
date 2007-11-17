Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 1D6CEDDDD5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 04:07:33 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so142370wri
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 09:07:32 -0800 (PST)
Date: Sat, 17 Nov 2007 11:06:58 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [POWERPC] [RFC] Fix 8xx tlbie definition
Message-ID: <20071117110658.7375dc1a@vader.jdub.homelinux.org>
In-Reply-To: <1195261547.28865.184.camel@pasglop>
References: <20071116112822.37a238c0@weaponx>
	<1195247189.28865.174.camel@pasglop>
	<20071117012837.4811d394@kernel.crashing.org>
	<1195261547.28865.184.camel@pasglop>
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

On Sat, 17 Nov 2007 12:05:47 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Sat, 2007-11-17 at 01:28 +0300, Vitaly Bordug wrote:
> > On Sat, 17 Nov 2007 08:06:29 +1100
> > Benjamin Herrenschmidt wrote:
> > 
> > > 
> > > On Fri, 2007-11-16 at 11:28 -0600, Josh Boyer wrote:
> > > > Git commit e701d269aa28996f3502780951fe1b12d5d66b49 introduced an
> > > > incorrect definition for _tlbie on PowerPC 8xx platforms.  Only the
> > > > address should be passed to the function.  This patch corrects the
> > > > definition of _tlbie and the related tlb flushing functions for 8xx.
> > > > 
> > > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > > 
> > > That conflicts with the patch I posted to fix it differently (I kept
> > > the additional argument).
> > > 
> > 
> > Where can I grab it to give a try? My linuxppc archive is silent for some reason..
> 
> Looks like I may have failed to post it ... weird, I was sure I posted
> that days ago, when Olof first mentioned the breakage. I'll check &
> resend.

I never saw it.  If I had, I wouldn't have bothered to post my own
version :)

> > > Which one do we take ?
> > > 
> > 
> > If your solution will work out, I'd agree with Kumar to have this thing consistent.
> > If not - It might be cheapier just to fix it this gross way, to keep 8xx stuff running. 

Consistency is fine with me.  I was going for quick and dirty to make
sure it wasn't broken in .24.

josh
