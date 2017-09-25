Return-Path: <jack@suse.cz>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0z1v6sH8zDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 19:14:59 +1000 (AEST)
Date: Mon, 25 Sep 2017 11:14:49 +0200
From: Jan Kara <jack@suse.cz>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 chandan <chandan@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org
Subject: Re: [linux-next][EXT4][Oops]kernel panics when running fsfuzzer
Message-ID: <20170925091449.GB5741@quack2.suse.cz>
References: <1505741461.6990.11.camel@abdul.in.ibm.com>
 <87lgl9lvhj.fsf@concordia.ellerman.id.au>
 <1506075381.17232.18.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506075381.17232.18.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 22-09-17 15:46:21, Abdul Haleem wrote:
> On Wed, 2017-09-20 at 16:44 +1000, Michael Ellerman wrote:
> > Is it reproducible?
> 
> No, bug is not seen once for 3 re-run from yesterday.
> 
> Hope to hit it again in the future CI runs.

I was also looking into this but I couldn't figure out what has happened.
>From the crash it seems that jh->b_bh->b_private was NULL although it
should point back to 'jh'. But that just doesn't seem possible so maybe it
is something different. If you ever happen to hit it again, please save
the fuzzed image so that it can be used for reproduction. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
