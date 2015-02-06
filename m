Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 087261A08A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Feb 2015 15:08:11 +1100 (AEDT)
Received: by mail-pa0-f49.google.com with SMTP id fa1so14473812pad.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2015 20:08:08 -0800 (PST)
Date: Thu, 5 Feb 2015 20:08:05 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 12/15] mtd: kconfig: replace PPC_OF with PPC
Message-ID: <20150206040805.GI18140@ld-irv-0074>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-13-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422712065-9403-13-git-send-email-haokexin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 31, 2015 at 09:47:42PM +0800, Kevin Hao wrote:
> The PPC_OF is a ppc specific option which is used to mean that the
> firmware device tree access functions are available. Since all the
> ppc platforms have a device tree, it is aways set to 'y' for ppc.
> So it makes no sense to keep a such option in the current kernel.
> Replace it with PPC.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Pushed to l2-mtd.git. Thanks.

Brian
