Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [5.9.151.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 180821A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 23:28:41 +1000 (AEST)
Message-ID: <1442928492.2018.9.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] sound/core/seq: make prioq_match return bool
From: Johannes Berg <johannes@sipsolutions.net>
To: Yaowei Bai <bywxiaobai@163.com>
Cc: perex@perex.cz, tiwai@suse.com, k.kozlowski@samsung.com,
 elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2015 15:28:12 +0200
In-Reply-To: <20150922132257.GB4221@bbox>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
 <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
 <1442844660.1876.2.camel@sipsolutions.net> <20150922132257.GB4221@bbox>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-22 at 21:22 +0800, Yaowei Bai wrote:
> On Mon, Sep 21, 2015 at 04:11:00PM +0200, Johannes Berg wrote:
> > 
> > > -static inline int prioq_match(struct snd_seq_event_cell *cell,
> > > +static inline bool prioq_match(struct snd_seq_event_cell *cell,
> > >  			      int client, int timestamp)
> > 
> > I think you should fix up the indentation now.
> 
> Sorry, I'm quite a new guy to linux kernel. I think you mean this 
> patch is not appropriate, right?
> 

No, the change itself is fine, but you should fix the indentation there
so it lines up properly after your change.

johannes
