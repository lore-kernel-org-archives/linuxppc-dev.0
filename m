Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 285B2DE671
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 01:43:52 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5329314wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 08:43:52 -0700 (PDT)
Date: Wed, 16 Jul 2008 09:43:49 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Message-ID: <20080716154349.GG24045@secretlab.ca>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<20080716141539.GC24045@secretlab.ca>
	<20080716103752.463e00cb@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080716103752.463e00cb@zod.rchland.ibm.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 16, 2008 at 10:37:52AM -0400, Josh Boyer wrote:
> On Wed, 16 Jul 2008 08:15:39 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> > On Wed, Jul 16, 2008 at 07:50:25AM -0400, Josh Boyer wrote:
> > > And then you don't need this file at all.  Just add a
> > > "amcc,canyonlands" string to your root node compatible property.
> > 
> > No!  Don't do this because it is not true!
> 
> Meh. You're splitting hairs.  It _is_ true from a kernel perspective.

... at this particular moment in time.  It may not be true 6 months from
now.

g.
