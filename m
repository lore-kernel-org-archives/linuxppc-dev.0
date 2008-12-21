Return-Path: <timur.tabi@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 4824DDDE24
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 14:19:24 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1317206rnf.16
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 19:19:23 -0800 (PST)
Message-ID: <ed82fe3e0812201919o619fd7e7jb87bbec551caa4d@mail.gmail.com>
Date: Sat, 20 Dec 2008 21:19:23 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ucc_geth: Fix TX watchdog timeout handling
In-Reply-To: <20081218182326.GB30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081218182326.GB30682@oksana.dev.rtsoft.ru>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>,
	Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 12:23 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> +static int ucc_geth_close(struct net_device *dev);
> +static int ucc_geth_open(struct net_device *dev);

I would prefer that you reorder the functions to eliminate the need
for forward references.

-- 
Timur Tabi
Linux kernel developer at Freescale
