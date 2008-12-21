Return-Path: <timur.tabi@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 25267DDE24
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 14:23:08 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d11so508394and.39
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 19:23:06 -0800 (PST)
Message-ID: <ed82fe3e0812201923s7ff3401i2d12aca4ae9de1e7@mail.gmail.com>
Date: Sat, 20 Dec 2008 21:23:06 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/6] ucc_geth: Remove UGETH_FILTERING dead code
In-Reply-To: <20081218182335.GF30682@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081218182335.GF30682@oksana.dev.rtsoft.ru>
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
> The code appears to be dead: nobody call these functions, plus build
> breaks when UGETH_FILTERING is enabled:

I general, I agree with patches like this, but I'd like to hear from
Leo first why this code was written in the first place before I can
ack it.

-- 
Timur Tabi
Linux kernel developer at Freescale
