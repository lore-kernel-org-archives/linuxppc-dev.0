Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FB55B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 11:18:28 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v6] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Fri, 1 Jul 2011 01:18:15 +0000
Message-ID: <BANLkTi=3r=UQYJVqRLRe-eu7rdkXQS-ESQ@mail.gmail.com>
References: <1307652726-4356-1-git-send-email-timur@freescale.com>
	<201106092304.55479.arnd@arndb.de>
In-Reply-To: <201106092304.55479.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cmetcalf@tilera.com" <cmetcalf@tilera.com>,
	"akpm@kernel.org" <akpm@kernel.org>,
	"dsaxena@linaro.org" <dsaxena@linaro.org>,
	"linux-console@vger.kernel.org" <linux-console@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 9, 2011 at 4:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 09 June 2011 22:52:06 Timur Tabi wrote:
>> Add the drivers/virt directory, which houses drivers that support
>> virtualization environments, and add the Freescale hypervisor management
>> driver.
....
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

So I've made the changes that people have asked for, and Arnd has
acked this driver.  Who's going to pick it up?  Who will be the
maintainer for drivers/virt?  I'd really like to see this driver in
3.1, and there's not much time left.

--=20
Timur Tabi
Linux kernel developer at Freescale=
