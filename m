Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12A0FB6FA2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 01:28:15 +1000 (EST)
Message-ID: <4DE8FD85.7000703@freescale.com>
Date: Fri, 3 Jun 2011 10:28:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de> <4DE8008E.9030008@freescale.com>
	<201106031724.44957.arnd@arndb.de>
In-Reply-To: <201106031724.44957.arnd@arndb.de>
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
>> > I don't think it's correct to think of a hypervisor as firmware, so I don't
>> > think drivers/firmware is better.
>> > 
>> > I'm not sure that creating virt/fsl and putting the driver in there is a good
>> > idea, because it will be the only driver in that directory.  Unlike KVM, this
>> > driver is just a collection of front-ends to our hypervisor API.  The actual
>> > hypervisor is completely separate.  That's why I put it in drivers/misc, because
>> > it's just a single driver with a miscellaneous collection of interfaces.

> Ok, fair enough. If nobody has a strong preference any other way, just make it
> drivers/firmware then.

Did you mean to say drivers/misc?

-- 
Timur Tabi
Linux kernel developer at Freescale
