Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBB712C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 02:11:49 +1000 (EST)
Message-ID: <1376323889.20487.7.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
From: Scott Wood <scottwood@freescale.com>
To: Zhang Haijun <B42677@freescale.com>
Date: Mon, 12 Aug 2013 11:11:29 -0500
In-Reply-To: <52084C7E.9000706@freescale.com>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
 <733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org>
 <52084C7E.9000706@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-12 at 10:46 +0800, Zhang Haijun wrote:
> On 08/09/2013 10:48 PM, Kumar Gala wrote:
> 
> > On Jul 31, 2013, at 1:25 AM, Haijun Zhang wrote:
> > 
> > > Add function to support get voltage from device-tree.
> > > If there are voltage-range specified in device-tree node, this function
> > > will parse it and return the avail voltage mask.
> > > 
> > > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > > ---
> > > changes for v2:
> > > 	- Update the parameters of function
> > > 
> > > drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > > include/linux/mmc/core.h |  1 +
> > > 2 files changed, 47 insertions(+)
> > There should be a device tree binding spec update to go with this patch series.
> > 
> > - k
> Hi, kumar
> 
> I'll update this tree binding spec after the patch set is accept by
> Anton.

Bindings should come first (or at least, at the same time).

-Scott
