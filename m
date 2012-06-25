Return-Path: <andrei.emeltchenko.news@gmail.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by ozlabs.org (Postfix) with ESMTP id D6B63B6F86
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 18:01:22 +1000 (EST)
Date: Mon, 25 Jun 2012 11:02:56 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] bluetooth: opcode field of sent commands is little endian.
Message-ID: <20120625080254.GB11001@aemeltch-MOBL1>
References: <1340606319-32187-1-git-send-email-michel@daenzer.net>
 <1340607113.29898.3.camel@aeonflux>
 <1340607965.5461.40.camel@thor.local>
 <1340608972.29898.13.camel@aeonflux>
 <1340609570.5461.50.camel@thor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1340609570.5461.50.camel@thor.local>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@intel.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michel,

On Mon, Jun 25, 2012 at 09:32:50AM +0200, Michel Dänzer wrote:
> > > Also, it would have been nice if that fix was promoted to stable, so I
> > > wouldn't have had to spend a good part of the weekend bisecting...
> > 
> > Thinks like this happen. However after you bisected the issue you could
> > have just checked what is in Linus' or bluetooth-next tree.
> 
> You're probably right. It just didn't occur to me that someone would
> have fixed this but not forwarded the fix to stable, because I generally
> do that. :}

Sorry for that, this and bunch of other fixes for byte order bugs needs to
be promoted to stable.

> Will you submit the fix to stable, or should I?

I added Gustavo to CC as he usually makes pull requests.

Best regards 
Andrei Emeltchenko 
