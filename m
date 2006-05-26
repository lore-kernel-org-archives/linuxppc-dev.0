Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29F9467AA0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 05:44:24 +1000 (EST)
Date: Fri, 26 May 2006 15:24:37 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH,
	2.6.17-rc4-git10] ieee80211softmac_io.c: fix warning "defined but not
	used"
Message-ID: <20060526192432.GC32487@tuxdriver.com>
References: <200605231549.43430.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200605231549.43430.toralf.foerster@gmx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 23, 2006 at 03:49:40PM +0200, Toralf Förster wrote:
> Got this compiler warning today and Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> Yeah, known 'bug', we have that code there but never use it. Feel free
> to submit a patch (to John Linville, CC netdev and softmac-dev) to
> remove it.
> 
> Signed-off-by: Toralf Foerster <toralf.foerster@gmx.de>

This patch is whitespace-damaged.  Please teach your mailer not to
convert tabs to spaces and resubmit.

Thanks!

John

> --- linux-2.6.17-rc4-git10-pcie-rme9652/net/ieee80211/softmac/ieee80211softmac_io.c.old 2006-05-12 09:44:47.000000000 +0200
> +++ linux-2.6.17-rc4-git10-pcie-rme9652/net/ieee80211/softmac/ieee80211softmac_io.c     2006-05-23 15:16:38.000000000 +0200
> @@ -456,31 +456,3 @@
>         return IEEE80211_2ADDR_LEN;
>  }
> 
> -
> -/* Sends a control packet */
> -static int
> -ieee80211softmac_send_ctl_frame(struct ieee80211softmac_device *mac,
> -       struct ieee80211softmac_network *net, u32 type, u32 arg)
> -{
> -       void *pkt = NULL;
> -       u32 pkt_size = 0;

<snip>

-- 
John W. Linville
linville@tuxdriver.com
