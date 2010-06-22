Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id ABB33B6F14
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 08:03:32 +1000 (EST)
Date: Wed, 23 Jun 2010 00:03:23 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>, Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
Message-ID: <20100623000323.41b953db@wker>
In-Reply-To: <AANLkTil0-hijJOvosWUEArVUOLDb_kLWIhfflj2C9pIK@mail.gmail.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<AANLkTil0-hijJOvosWUEArVUOLDb_kLWIhfflj2C9pIK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tue, 22 Jun 2010 11:29:50 -0500
Timur Tabi <timur@freescale.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> > This patch series rework DIU support patches submitted
> > previously. Comments to the previos patch series have
> > been addressed, not related changes are dropped and some
> > changes are split out to separate patches to simplify
> > review. Furthermore a patch has been added to support
> > setting display mode using EDID block in the device tree.
> 
> All five patches:
> 
> Acked-by: Timur Tabi <timur@freescale.com>
> 
> Tested on an MPC8610 HPCD.

Thanks for testing!

Grant, could you please queue these patches for 2.6.36?

Thanks,
Anatolij
