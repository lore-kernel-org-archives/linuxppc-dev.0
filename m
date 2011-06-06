Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 570B7B6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 01:48:18 +1000 (EST)
Message-ID: <4DECF6B3.5020700@freescale.com>
Date: Mon, 6 Jun 2011 10:48:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106031724.44957.arnd@arndb.de> <4DE8FD85.7000703@freescale.com>
	<201106061742.01974.arnd@arndb.de>
In-Reply-To: <201106061742.01974.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
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

Arnd Bergmann wrote:
> Sorry, I misread your first sentence above. I thought you said that you prefer
> drivers/firmware over virt/fsl. drivers/misc is definitely the wrong
> place for this, please choose a better one. Maybe drivers/virt/ ?

I'll be more than happy to go with the consensus, but I don't think it makes
sense to create a new directory just for this one, limited-use driver.  You're
the only person who's complained about drivers/misc.  I'm pretty sure that if I
put it in drivers/virt, I'll get more complaints.

I still don't understand what's wrong with drivers/misc, especially since my
driver registers as a "misc" driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
