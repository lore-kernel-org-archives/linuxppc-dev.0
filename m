Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Make many functions 'static' 
In-reply-to: <20080804053013.GC7086@yookeroo.seuss> 
References: <20080804053013.GC7086@yookeroo.seuss>
Date: Wed, 13 Aug 2008 13:09:07 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KTKmR-0000JM-Cb@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch marks various functions not shared between c files
> 'static', as they should be.  There are a couple of functions in dtc,
> and many in the testsuite.
> 
> This is *almost* enough to enable the -Wmissing-prototypes warning.
> It's not quite enough, because there's a mess of junk in the flex
> generated code which triggers that warning which I'm not yet sure how
> to deal with.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
