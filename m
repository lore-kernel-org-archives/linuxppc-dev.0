Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Abolish fdt_offset_ptr_typed() 
In-Reply-To: Your message of "Mon, 19 Nov 2007 17:26:22 +1100."
	<20071119062622.GL20794@localhost.localdomain>
References: <20071119062622.GL20794@localhost.localdomain> 
Date: Tue, 20 Nov 2007 09:06:11 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IuUfz-00021k-R8@jdl.com>
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
> The fdt_offset_ptr_typed() macro seemed like a good idea at the time.
> However, it's not actually used all that often, it can silently throw
> away const qualifications and it uses a gcc extension (typeof) which
> I'd prefer to avoid for portability.
> 
> Therefore, this patch gets rid of it (and the fdt_offset_ptr_typed_w()
> variant which was never used at all).  It also makes a few variables
> const in testcases, which always should have been const, but weren't
> caught before because of the aforementioned silent discards.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
