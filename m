Return-Path: <afleming@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 73BB0B6F7B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 09:51:33 +1100 (EST)
Received: by ywp31 with SMTP id 31so2183409ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2011 15:51:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1319144425-15547-18-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1319144425-15547-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <1319144425-15547-18-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 3 Nov 2011 17:51:29 -0500
Message-ID: <CAKWjMd51V-r_t85KvHRGQ=ddu0bWXC05piRhi2WrkqsHTr+WRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 17/17] phy_device: Rename phy_start_aneg() to
 phy_start_link()
From: Andy Fleming <afleming@gmail.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
 Stephen Hemminger <shemminger@vyatta.com>, David Decotigny <decot@google.com>,
 devel@driverdev.osuosl.org, Matt Carlson <mcarlson@broadcom.com>,
 Kuninori Morimoto <morimoto.kuninori@renesas.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, Mike Frysinger <vapier@gentoo.org>,
 =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
 Michael Chan <mchan@broadcom.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 John Crispin <blogic@openwrt.org>,
 Richard Cochran <richard.cochran@omicron.at>, Ilya Yanok <yanok@emcraft.com>,
 netdev@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>,
 Ralph Hempel <ralph.hempel@lantiq.com>, Jon Mason <jdmason@kudzu.us>,
 Joe Perches <joe@perches.com>, Steve Glendinning <steve.glendinning@smsc.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kristoffer Glembo <kristoffer@gaisler.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/10/20 Kyle Moffett <Kyle.D.Moffett@boeing.com>:
> The name of the "phy_start_aneg()" function is very confusing, because
> it also handles forced-mode (AUTONEG_DISABLE) links.
>
> Rename the function to phy_start_link() and fix up all users.
>
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>

Sounds good to me.

Acked-by: Andy Fleming <afleming@freescale.com>
