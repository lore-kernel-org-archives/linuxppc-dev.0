Return-Path: <randy.dunlap@oracle.com>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rcsinet10.oracle.com",
	Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 949AAB6FD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 02:42:54 +1000 (EST)
Message-ID: <4DF0F7F5.5050107@oracle.com>
Date: Thu, 09 Jun 2011 09:42:29 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<20110608161009.7b05d305.randy.dunlap@oracle.com>
	<201106090938.23027.arnd@arndb.de>
	<4DF0F5A1.5080008@oracle.com> <4DF0F672.8040206@freescale.com>
In-Reply-To: <4DF0F672.8040206@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com, greg@kroah.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com,
	Linux Virtualization <virtualization@lists.linux-foundation.org>,
	dsaxena@linaro.org, linux-console@vger.kernel.org,
	akpm@kernel.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/11 09:36, Timur Tabi wrote:
> Randy Dunlap wrote:
>> But it sounds like virt/ needs virt/host/ and virt/guest/ to me.
> 
> I'm okay with that idea, except there's a consensus that drivers should be in
> drivers/.
> 

Like sound/ ?

but what makes it a "driver"?

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
