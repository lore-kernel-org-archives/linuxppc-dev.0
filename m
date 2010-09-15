Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8328B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 01:14:04 +1000 (EST)
In-Reply-To: <4C90CA4D.2020902@c-s.fr>
References: <4C90CA4D.2020902@c-s.fr>
Subject: Re: [PATCH] fixes probe issue and hangup in spi_mpc8xxx.c for data
	bigger than PAGE_SIZE
To: LEROY Christophe <christophe.leroy@c-s.fr>
Message-ID: <OFE529E700.F5762D7C-ONC125779F.0052EF12-C125779F.005327C5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 15 Sep 2010 17:08:16 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>   This patch applies to 2.6.34.7. It also applies to 2.6.35.4 althought
> part of it is already included in 2.6.35.4
> It fixed a problem with spi_mpc8xxx.c when transmitting or receiving
> data bigger than PAGE_SIZE when doing a read only or write only operation
> It also fixed an issue with the init probe when fetching the information
> on parameter RAM from the DTB.

I think you need to break this up into 3 patches. It can't go into Linus
tree as is and it can't go into stable before it is in Linus tree.

    Jocke
