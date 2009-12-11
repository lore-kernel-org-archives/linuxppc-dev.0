Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 859D6B6EEF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 12:57:23 +1100 (EST)
Subject: Re: [PATCH 2/3] powerpc/83xx/suspend: Save and restore SICRL,
	SICRH and SCCR
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091210180056.GB32482@oksana.dev.rtsoft.ru>
Date: Thu, 10 Dec 2009 19:57:05 -0600
Message-Id: <CC099D72-7930-4F25-A507-7BB64A056EB7@kernel.crashing.org>
References: <20091210175957.GA30682@oksana.dev.rtsoft.ru>
	<20091210180056.GB32482@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 10, 2009, at 12:00 PM, Anton Vorontsov wrote:

> We need to save SICRL, SICRH and SCCR registers on suspend, and =
restore
> them on resume. Otherwise, we lose IO and clocks setup on MPC8315E-RDB
> boards when ULPI USB PHY is used (non-POR setup).
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/platforms/83xx/suspend.c |   48 =
+++++++++++++++++++++++++++++++++
> 1 files changed, 48 insertions(+), 0 deletions(-)

applied to next

- k=
