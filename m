Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F6B6DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 12:40:28 +1100 (EST)
Message-ID: <49406F61.2000004@emcraft.com>
Date: Thu, 11 Dec 2008 04:39:45 +0300
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
References: <1228858740.22413.28.camel@pasglop>
	<1228917536-8308-1-git-send-email-yanok@emcraft.com>
In-Reply-To: <1228917536-8308-1-git-send-email-yanok@emcraft.com>
Content-Type: text/plain; charset=KOI8-R
Cc: Vladimir Panfilov <pvr@emcraft.com>, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello guys,

please discard this patch. It just doesn't compile with CONFIG_HIGHMEM
set. I'll post updated patch in a short time.

Excuse me.

Regards, Ilya.
