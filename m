Return-Path: <greg@kroah.com>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A55FB6F9A
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 02:32:40 +1000 (EST)
Date: Thu, 25 Aug 2011 09:32:34 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] tty/powerpc: fix build break with ehv_bytechan.c on
	allyesconfig
Message-ID: <20110825163234.GA31629@kroah.com>
References: <1314289245-14946-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314289245-14946-1-git-send-email-timur@freescale.com>
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2011 at 11:20:45AM -0500, Timur Tabi wrote:
> The Kconfig for the ePAPR hypervisor byte channel driver has a "depends on PPC",
> which means it would compile on all PowerPC platforms, even though it's
> only been tested on Freescale platforms.  Change the Kconfig to depend on
> FSL_SOC instead.

tested doesn't mean that it shouldn't still build properly for other
platforms, right?

What is keeping the driver from building on all PPC, or even all arches
today?

greg k-h
