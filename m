Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Use libfdt endian conversion functions in libfdt 
In-reply-to: <20080626004306.GG308@yookeroo.seuss> 
References: <20080626004306.GG308@yookeroo.seuss>
Date: Mon, 14 Jul 2008 13:50:27 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KIT7z-0006qg-9E@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Following on from the last patch, which made dtc use the same endian
> conversion functions as libfdt, this patch makes ftdump use these
> functions as well.  This brings us down to a single set of endian
> handling functions in all of dtc and libfdt, so just one place to fix
> things.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
