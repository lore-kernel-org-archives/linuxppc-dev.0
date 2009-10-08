Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E03D1B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 20:10:11 +1100 (EST)
Date: Thu, 08 Oct 2009 02:10:25 -0700 (PDT)
Message-Id: <20091008.021025.13024270.davem@davemloft.net>
To: jezz@sysmic.org
Subject: Re: [PATCH] Remove nested function
From: David Miller <davem@davemloft.net>
In-Reply-To: <1254990863-15271-1-git-send-email-jezz@sysmic.org>
References: <fa686aa40910070911x769d7d41u908fbcf6b0980962@mail.gmail.com>
	<1254990863-15271-1-git-send-email-jezz@sysmic.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: J=E9r=F4me Pouiller <jezz@sysmic.org>
Date: Thu,  8 Oct 2009 10:34:23 +0200

> Some toolchains dislike nested function definition, so we define func=
tion match
> outside of of_phy_find_device.
> =

> Signed-off-by: J=E9r=F4me Pouiller <jezz@sysmic.org>

Acked-by: David S. Miller <davem@davemloft.net>
