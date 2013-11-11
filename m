Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DEA212C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 07:10:29 +1100 (EST)
Date: Mon, 11 Nov 2013 21:10:24 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v5 2/5] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20131111201024.GR17929@book.gsilab.sittig.org>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-3-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383290374-17484-3-git-send-email-a13xp0p0v88@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 11:19 +0400, Alexander Popov wrote:
> 
> Introduce support for slave s/g transfer preparation and the associated
> device control callback in the MPC512x DMA controller driver, which adds
> support for data transfers between memory and peripheral I/O to the
> previously supported mem-to-mem transfers.

Alexander, there is outstanding review feedback for a previous
version of the series that you haven't addressed yet.  Can you
please either look into those issues, or state that it's OK to
leave them and why this is so?  It would be nice to get a
response to the feedback that you are given.  It may be
appropriate not to obey to the feedback, but at least it should
get considered.

Have you noticed the recent introduction of the dmaengine@vger
ML?  Make sure to include it upon the next submission.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
