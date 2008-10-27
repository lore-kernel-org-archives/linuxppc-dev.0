Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C336DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 05:52:43 +1100 (EST)
Message-ID: <49060DF0.6040607@garzik.org>
Date: Mon, 27 Oct 2008 14:52:32 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH] ehea: Add hugepage detection
References: <200810271038.46825.tklein@de.ibm.com>
In-Reply-To: <200810271038.46825.tklein@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: badari@us.ibm.com, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, tollefso@us.ibm.com,
	Hannes Hering <hering2@de.ibm.com>, haveblue@us.ibm.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Klein wrote:
> All kernel memory which is used for kernel/hardware data transfer must be registered
> with firmware using "memory regions". 16GB hugepages may not be part of a memory region
> due to firmware restrictions.
> This patch modifies the walk_memory_resource callback fn to filter hugepages and add
> only standard memory to the busmap which is later on used for MR registration.
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> ---
> This reworked patch accounts for comments I got. It's based on davem's net-2.6.git.

applied
