Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9B3E6DE566
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 07:33:46 +1000 (EST)
Subject: Re: linux-next: manual merge of the powerpc tree
From: Daniel Walker <dwalker@mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080707230717.10429faf.sfr@canb.auug.org.au>
References: <20080707230717.10429faf.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 14:13:15 -0700
Message-Id: <1215465195.15313.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-07-07 at 23:07 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the powerpc tree got a conflict in
> drivers/macintosh/mediabay.c between commit
> 7ad963b103d3863b1161c59f3e65a435979804ed ("ide-pmac: media-bay support
> fixes (take 4)") from the ide tree and commit
> 9a24729d8aeef967eac7af71c6a69edc83d06558 ("macintosh/media bay: Convert
> semaphore to mutex") from the powerpc tree.
> 
> I just applied the up/down -> mutex_unlock/mutex_lock change to the ide
> tree version.


It doesn't look like the IDE patches change the locking at all, so the
semaphore to mutex change should still be safe every with the IDE
changes.

>From an organizational prospective, I think it makes sense for the IDE
changes to go on top of the powerpc.git mediabay changes .. Since the
most current mediabay driver is in the powerpc.git AFAIK.

Daniel
