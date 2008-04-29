Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78318DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 04:46:34 +1000 (EST)
Date: Tue, 29 Apr 2008 20:46:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
Message-ID: <20080429184623.GA23654@lst.de>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
	<20080429184047.47CB7247B4@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080429184047.47CB7247B4@gemini.denx.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>, mtk.manpages@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 08:40:47PM +0200, Wolfgang Denk wrote:
> This probably depends a bit on  the  performance  of  the  system  in
> question. Did you measure it - for example - on a 50 MHz MPC850 ?

You got a 64bit kernel to run on a MPC850? wow :)

Not sure what the slowest supported 64bit cpu is (RS64-II?), but Paul
might be right and in this case it really doesn't matter.
