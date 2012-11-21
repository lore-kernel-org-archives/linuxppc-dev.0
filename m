Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 421B32C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 22:59:15 +1100 (EST)
Date: Wed, 21 Nov 2012 11:58:48 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 238/493] mtd: remove use of __devinit
Message-ID: <20121121115848.GI3290@n2100.arm.linux.org.uk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-238-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-238-git-send-email-wfp5p@virginia.edu>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Wan ZongShun <mcuos.com@gmail.com>, gregkh@linuxfoundation.org,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:23:07PM -0500, Bill Pemberton wrote:
>  drivers/mtd/maps/pismo.c               | 14 +++++++-------
>  drivers/mtd/maps/sa1100-flash.c        |  5 ++---

For these two,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
