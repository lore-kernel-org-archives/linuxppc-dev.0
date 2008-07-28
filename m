Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id D12DADDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 02:49:25 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5881137wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 09:49:24 -0700 (PDT)
Date: Mon, 28 Jul 2008 10:49:22 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: T Ziomek <ctz001@email.mot.com>
Subject: Re: [RFC,PATCH] scripts/package: add powerpc images to tarball
Message-ID: <20080728164922.GA21159@secretlab.ca>
References: <1216887460.306306.238738123378.1.gpush@pingu>
	<200807250108.m6P18f4B099179@sullivan.realtime.net>
	<fa686aa40807252155l4f785920qdb14d117067b30f4@mail.gmail.com>
	<913573e2092839fbe37a0bfa37119eb6@bga.com>
	<fa686aa40807261053r5a8ebe40l7e8061f926f185f9@mail.gmail.com>
	<20080728163435.GE27068@email.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080728163435.GE27068@email.mot.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 11:34:35AM -0500, T Ziomek wrote:
> On Sat, Jul 26, 2008 at 01:53:57PM -0400, Grant Likely wrote:
>  . . .
> > Come to think of it, I'd support just removing the zImage symlink
> > entirely to eliminate confusion so that everyone knows that 'make
> > zImage' is the 'make all' for default image targets.
> 
> That ("zImage" means all default image targets) seems pretty non-intui-
> tive; why not something like 'make all_def_images'?

It is purely historical.  zImage and modules have been the default
make targets for a long time.  I'm not opposed to changing it, but it is
a change that affects almost everyone.  I'd like to see some consensus
before going down this path.

g.
