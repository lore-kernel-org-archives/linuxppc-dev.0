Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 1966BDDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 22:13:45 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2059843wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 03:13:43 -0800 (PST)
Message-ID: <2a27d3730812220313w5882edb8nf7c2978cd0dcac5f@mail.gmail.com>
Date: Mon, 22 Dec 2008 19:13:43 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH 6/6] ucc_geth: Remove UGETH_FILTERING dead code
In-Reply-To: <ed82fe3e0812201923s7ff3401i2d12aca4ae9de1e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20081218182335.GF30682@oksana.dev.rtsoft.ru>
	<ed82fe3e0812201923s7ff3401i2d12aca4ae9de1e7@mail.gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>, Jeff Garzik <jgarzik@pobox.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 21, 2008 at 11:23 AM, Timur Tabi <timur@freescale.com> wrote:
> On Thu, Dec 18, 2008 at 12:23 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
>> The code appears to be dead: nobody call these functions, plus build
>> breaks when UGETH_FILTERING is enabled:
>
> I general, I agree with patches like this, but I'd like to hear from
> Leo first why this code was written in the first place before I can
> ack it.

The code was there to test the frame filtering feature which probably
can be used in multicast and VLAN support.  I didn't remove it because
it could be a base for whoever interested to implement a general frame
filtering framework or custom features.  Given the fact that unused
code can easily become broken.  I agree that it can be removed for
now.

Acked-by: Li Yang <leoli@freescale.com>
