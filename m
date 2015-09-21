Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (s3.sipsolutions.net [5.9.151.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D4EC1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 00:46:57 +1000 (AEST)
Message-ID: <1442844660.1876.2.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] sound/core/seq: make prioq_match return bool
From: Johannes Berg <johannes@sipsolutions.net>
To: Yaowei Bai <bywxiaobai@163.com>, perex@perex.cz, tiwai@suse.com,
 k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be,
 lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2015 16:11:00 +0200
In-Reply-To: <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
 <1442843834-4648-4-git-send-email-bywxiaobai@163.com>
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


> -static inline int prioq_match(struct snd_seq_event_cell *cell,
> +static inline bool prioq_match(struct snd_seq_event_cell *cell,
>  			      int client, int timestamp)

I think you should fix up the indentation now.

johannes
