Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2B0042C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 21:41:32 +1100 (EST)
Date: Sun, 17 Feb 2013 10:19:58 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] of: use platform_device_add
Message-ID: <20130217101958.GR17833@n2100.arm.linux.org.uk>
References: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
 <1358473200-17886-2-git-send-email-grant.likely@secretlab.ca>
 <20130217030331.GA15048@S2101-09.ap.freescale.net>
 <20130217074317.GB16632@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130217074317.GB16632@S2101-09.ap.freescale.net>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 17, 2013 at 03:43:20PM +0800, Shawn Guo wrote:
> It also breaks all of_amba_device users.
> 
> of_amba_device_create() --> amba_device_add() --> request_resource()
> and fails.

Presumably that's because we no longer know what the parent resource
is supposed to be?
