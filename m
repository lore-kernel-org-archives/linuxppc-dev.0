Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Rename and publish _fdt_check_header() 
In-Reply-To: Your message of "Wed, 24 Oct 2007 10:28:52 +1000."
	<20071024002852.GG10595@localhost.localdomain>
References: <20071024002852.GG10595@localhost.localdomain> 
Date: Wed, 24 Oct 2007 08:00:04 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ikfq8-0008Ct-HU@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> It's potentially useful for users of libfdt to sanity check a device
> tree (or, rather, a blob of data which may or may not be a device
> tree) before processing it in more detail with libfdt.
> 
> This patch renames the libfdt internal function _fdt_check_header() to
> fdt_check_header() and makes it a published function, so it can now be
> used for this purpose.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
