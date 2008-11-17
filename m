Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Check return value from fwrite() 
In-reply-to: <20081107004111.GG6692@yookeroo.seuss> 
References: <20081107004111.GG6692@yookeroo.seuss>
Date: Mon, 17 Nov 2008 14:08:41 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1L2AOn-0003ef-2Q@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There's one place in flattree.c where we currently ignore the return
> value from fwrite().  On some gcc/glibc versions, where fwrite() is
> declared with attribute warn_unused_result, this causes a warning.
> 
> This patch fixes the warning, by checking the fwrite() result.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
