Return-Path: <bzolnier@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 72816DE077
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 05:05:45 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so997716yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 12:05:43 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the powerpc tree
Date: Fri, 11 Jul 2008 21:01:25 +0200
References: <20080707230717.10429faf.sfr@canb.auug.org.au>
In-Reply-To: <20080707230717.10429faf.sfr@canb.auug.org.au>
MIME-Version: 1.0
Message-Id: <200807112101.25704.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: Daniel Walker <dwalker@mvista.com>, linuxppc-dev@ozlabs.org,
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


Hi,

On Monday 07 July 2008, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the powerpc tree got a conflict in
> drivers/macintosh/mediabay.c between commit
> 7ad963b103d3863b1161c59f3e65a435979804ed ("ide-pmac: media-bay support
> fixes (take 4)") from the ide tree and commit
> 9a24729d8aeef967eac7af71c6a69edc83d06558 ("macintosh/media bay: Convert
> semaphore to mutex") from the powerpc tree.

Since I haven't heard back from Ben [1] on ide-pmac/media-bay IRQ issue
I took another look at ide-pmac patches and I think that it should be
possible to rework them in such way that consecutive ide patches (> 100)
won't depend on "ide-pmac: media-bay support fixes (take 4)" patch.

This would allow us to re-schedule it to 2.6.28 (which is probably what
we want because 2.6.26 is probably just around the corner and we will be
pretty busy with 2.6.27 merge window soon).  Ben, what's your opinion?

[1] which doesn't surprise me given his new responsibilities ;)

Thanks,
Bart
