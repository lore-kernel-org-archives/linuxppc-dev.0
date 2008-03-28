Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AF60DDFAA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:59:50 +1100 (EST)
Message-ID: <47ED6A4F.1070003@pobox.com>
Date: Fri, 28 Mar 2008 17:59:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 6/6] PS3: Gelic network driver Wake-on-LAN support
References: <20080327001821.827672589@am.sony.com>
	<47EAECC3.1030200@am.sony.com>
In-Reply-To: <47EAECC3.1030200@am.sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
> 
> Add Wake-on-LAN support to the PS3 Gelic network driver.
> Other OS WOL support was introduced in PS3 system firmware
> 2.20.
> 
> Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  drivers/net/ps3_gelic_net.c |   81 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/ps3_gelic_net.h |   20 ++++++++++
>  2 files changed, 101 insertions(+)

ACK
