Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id EF489DDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 03:02:06 +1100 (EST)
Date: Mon, 11 Feb 2008 17:02:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
Message-ID: <20080211160211.GA22139@uranus.ravnborg.org>
References: <200802111657.07534.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802111657.07534.ossthema@de.ibm.com>
Cc: "Themann, Jan-Bernd" <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2008 at 04:57:06PM +0100, Jan-Bernd Themann wrote:
> Drivers like eHEA need memory notifiers in order to 
> update their internal DMA memory map when memory is added
> to or removed from the system.

Can you please add proper kernel-doc formatted comments
when you export a symbol so others can get a clue
what the exported function is supposed to do.

	Sam
