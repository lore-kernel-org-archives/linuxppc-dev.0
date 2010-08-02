Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 15EB01007D4
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 16:52:55 +1000 (EST)
Received: by bwz11 with SMTP id 11so2101656bwz.15
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Aug 2010 23:52:53 -0700 (PDT)
Date: Mon, 2 Aug 2010 10:52:51 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits workaround
Message-ID: <20100802065251.GA25697@oksana.dev.rtsoft.ru>
References: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com>
	<20100730070624.GB20351@oksana.dev.rtsoft.ru>
	<83024545B35D6445A690EFD603E7869A07ED05@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <83024545B35D6445A690EFD603E7869A07ED05@zch01exm23.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 02, 2010 at 02:19:58PM +0800, Zang Roy-R61911 wrote:
[...]
> > For p4080 it will be 'voltage-ranges = <3200 3400>;'. So, with
> > voltage-ranges we can do fine grained VDD control without
> > introducing anything new.
> why not
>                voltage-ranges = <3300 3300>;

Right you are, both will be 3300.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
