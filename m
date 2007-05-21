Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 10775DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 03:14:06 +1000 (EST)
Date: Mon, 21 May 2007 19:14:16 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] remove geometry support from ps3 storage driver
Message-ID: <20070521171416.GB1125@aepfle.de>
References: <20070521125311.GA27626@aepfle.de> <20070521143938.GA20321@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070521143938.GA20321@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 21, Christoph Hellwig wrote:

> On Mon, May 21, 2007 at 02:53:11PM +0200, Olaf Hering wrote:
> > 
> > The old ps3_storage driver did not support DOS geometry, so there is no
> > point to start adding code for it.
> 
> That's not quite true.  sd applies some heuristics  and has a default
> geometry if there is no ->bios_param method.  Then again this whole
> gemetry thing really only makes sense on x86.

Ok, if it really matters, the values should match sd.
