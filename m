Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0CBE1A0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 12:17:38 +1100 (AEDT)
Message-ID: <1454635050.2486.25.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Li Yang <leoli@freescale.com>, Raghav Dogra <raghav@freescale.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>,  prabhakar.kushwaha@nxp.com, Brian Norris
 <computersforpeace@gmail.com>,  Jaiprakash Singh <b44839@freescale.com>
Date: Thu, 04 Feb 2016 19:17:30 -0600
In-Reply-To: <CADRPPNTKFA8rkynJR4wCNgAmqvmiwYwTi2Uk9hDUMB4+N7ST_Q@mail.gmail.com>
References: <1454481372-10288-1-git-send-email-raghav@freescale.com>
 <CADRPPNTKFA8rkynJR4wCNgAmqvmiwYwTi2Uk9hDUMB4+N7ST_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] mtd/ifc: Add support for IFC controller version 2.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-04 at 17:07 -0600, Li Yang wrote:
> On Wed, Feb 3, 2016 at 12:36 AM, Raghav Dogra <raghav@freescale.com> wrote:
> > The new IFC controller version 2.0 has a different memory map page.
> > Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0 PAGE size is 64KB.
> > This patch segregates the IFC global and runtime registers to appropriate
> > PAGE sizes.
> 
> If the global registers and the runtime registers are so independent
> that they have to be on different page boundaries, it would make more
> sense for them to be defined as separate reg regions in the device
> tree at the very beginning.  Then we would only need to change the
> device tree now and it would be future proof for any page size.

That's great if you have a time machine.  Otherwise, NACK.

-Scott
