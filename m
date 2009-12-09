Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33761B7ED1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 08:17:19 +1100 (EST)
Subject: Re: [PATCH 2/4] mpc8349emitx: populate I2C busses
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1258379934-32352-3-git-send-email-dbaryshkov@gmail.com>
Date: Wed, 9 Dec 2009 15:17:14 -0600
Message-Id: <A235B6F6-D217-4B28-94C0-E67C0B092DC1@kernel.crashing.org>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
	<1258379934-32352-3-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2009, at 7:58 AM, Dmitry Eremin-Solenikov wrote:

> Add OF descriptions of EEPROM, two GPIO extenders and SPD hanging on I2C
> on this board.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/boot/dts/mpc8349emitx.dts |   25 +++++++++++++++++++++++++
> 1 files changed, 25 insertions(+), 0 deletions(-)

applied to next

- k
