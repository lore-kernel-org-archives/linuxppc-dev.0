Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17582.14562.991790.920984@cargo.ozlabs.ibm.com>
Date: Fri, 7 Jul 2006 20:35:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 15/20] [powerpc,
	netdevices] Constify & voidify get_property()
In-Reply-To: <98457831@toto.iv>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, netdev@oss.sgi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy Kerr writes:

> powerpc-specific network device driver changes.

For some reason, the whitespace got munged on this one.  There were
some rejects on some of the other patches due to some of Ben H's
patches.  Please fix them and move the include/linux/platform_device.h
change into the same patch as the drivers/base/platform.c change.

I have applied patches 1-3.  Please resubmit the rest.

Regards,
Paul.
