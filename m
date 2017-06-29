Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyp6b01x0zDr4g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 15:26:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>, Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: remapping too much memory
In-Reply-To: <20170628114907.kf3t65mrdbq7rsfm@mwanda>
References: <20170628114907.kf3t65mrdbq7rsfm@mwanda>
Date: Thu, 29 Jun 2017 15:26:14 +1000
Message-ID: <87bmp7bc09.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> There is a cut and paste error here so we use "sizeof(struct mpc83xx_pmc)"
> to remap the memory for "clock_regs".  That sizeof() is 20 bytes and we
> only need to remap 12 bytes.  It presumably doesn't affect run time too
> much...

I don't know 83xx well, but I suspect mappings occur on a 4K granularity
at a minimum :)

> I changed them to both use "sizeof(*variable_name)" because that's the
> prefered kernel style these days.

Thanks.

cheers
