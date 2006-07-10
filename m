Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 15/20] [powerpc,
	netdevices] Constify & voidify get_property()
Date: Mon, 10 Jul 2006 13:40:21 +1000
References: <17582.14562.991790.920984@cargo.ozlabs.ibm.com>
In-Reply-To: <17582.14562.991790.920984@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607101340.22068.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

> For some reason, the whitespace got munged on this one.

Hm, that's odd - you mean the patch doesn't apply, or that it introduces 
incorrect whitepace? I can apply this patch (from patchwork or the list 
archives) without problems.

> There were some rejects on some of the other patches due to some of
> Ben H's patches. Please fix them and move the
> include/linux/platform_device.h change into the same patch as the
> drivers/base/platform.c change.

Sure thing. patches coming.


Jeremy
