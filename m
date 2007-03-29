Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3B70DDDEC4
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 00:46:26 +1000 (EST)
Date: Thu, 29 Mar 2007 16:46:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 10/10] powerpc: Add uevent handler for ibmebus
Message-ID: <20070329144623.GA5718@aepfle.de>
References: <11713184091057-git-send-email-tnt@246tNt.com>
	<11713184101239-git-send-email-tnt@246tNt.com>
	<11713184112187-git-send-email-tnt@246tNt.com>
	<11713184132161-git-send-email-tnt@246tNt.com>
	<11713184141191-git-send-email-tnt@246tNt.com>
	<11713184152189-git-send-email-tnt@246tNt.com>
	<11713184171985-git-send-email-tnt@246tNt.com>
	<11713184182928-git-send-email-tnt@246tNt.com>
	<1171318420572-git-send-email-tnt@246tNt.com>
	<11713184211154-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <11713184211154-git-send-email-tnt@246tNt.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 12, Sylvain Munaut wrote:

>  arch/powerpc/kernel/ibmebus.c |   16 ++++++++++++++++

> +	if (ebus_dev==ibmebus_bus_device)	/* filter dummy root device */

Does that compile for you?
ibmebus_bus_device should be &ibmebus_bus_device
