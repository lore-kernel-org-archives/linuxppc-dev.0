Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 85DA7B6FAB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 01:42:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Mon, 6 Jun 2011 17:42:01 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106031724.44957.arnd@arndb.de> <4DE8FD85.7000703@freescale.com>
In-Reply-To: <4DE8FD85.7000703@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106061742.01974.arnd@arndb.de>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 03 June 2011, Timur Tabi wrote:
> Arnd Bergmann wrote:
> >> > I don't think it's correct to think of a hypervisor as firmware, so I don't
> >> > think drivers/firmware is better.
> >> > 
> >> > I'm not sure that creating virt/fsl and putting the driver in there is a good
> >> > idea, because it will be the only driver in that directory.  Unlike KVM, this
> >> > driver is just a collection of front-ends to our hypervisor API.  The actual
> >> > hypervisor is completely separate.  That's why I put it in drivers/misc, because
> >> > it's just a single driver with a miscellaneous collection of interfaces.
> 
> > Ok, fair enough. If nobody has a strong preference any other way, just make it
> > drivers/firmware then.
> 
> Did you mean to say drivers/misc?

Sorry, I misread your first sentence above. I thought you said that you prefer
drivers/firmware over virt/fsl. drivers/misc is definitely the wrong
place for this, please choose a better one. Maybe drivers/virt/ ?

	Arnd
