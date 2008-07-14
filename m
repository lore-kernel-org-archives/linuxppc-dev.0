Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Use stdint.h types throughout dtc 
In-reply-to: <20080625035307.GB8284@yookeroo.seuss> 
References: <20080625035307.GB8284@yookeroo.seuss>
Date: Mon, 14 Jul 2008 13:49:40 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KIT7F-0006q6-09@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Currently, dtc defines Linux-like names for various fixed-size integer
> types.  There's no good reason to do this; even Linux itself doesn't
> use these names for externally visible things any more.  This patch
> replaces these with the C99 standardized type names from stdint.h.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
