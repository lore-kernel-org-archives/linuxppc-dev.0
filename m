Return-Path: <bywxiaobai@163.com>
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
 by lists.ozlabs.org (Postfix) with ESMTP id B48671A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 23:40:35 +1000 (AEST)
Date: Tue, 22 Sep 2015 21:22:57 +0800
From: Yaowei Bai <bywxiaobai@163.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: perex@perex.cz, tiwai@suse.com, k.kozlowski@samsung.com,
 elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sound/core/seq: make prioq_match return bool
Message-ID: <20150922132257.GB4221@bbox>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
 <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
 <1442844660.1876.2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442844660.1876.2.camel@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2015 at 04:11:00PM +0200, Johannes Berg wrote:
> 
> > -static inline int prioq_match(struct snd_seq_event_cell *cell,
> > +static inline bool prioq_match(struct snd_seq_event_cell *cell,
> >  			      int client, int timestamp)
> 
> I think you should fix up the indentation now.

Sorry, I'm quite a new guy to linux kernel. I think you mean this patch
is not appropriate, right?

> 
> johannes
