Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18259.35370.588914.613689@cargo.ozlabs.ibm.com>
Date: Mon, 3 Dec 2007 15:46:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] pasemi: Fix module information for gpio-mdio
In-Reply-To: <20071203044016.GA24068@lixom.net>
References: <20071203044016.GA24068@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> Fix up the module information for gpio-mdio, it wouldn't load
> because of lacking license, and wouldn't auto-load because of missing
> MODULE_DEVICE_TABLE.

Needed for 2.6.24?

Paul.
