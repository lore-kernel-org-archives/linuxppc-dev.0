Return-Path: <gmane@reliableembeddedsystems.com>
Received: from delivery.mailspamprotection.com
 (delivery.mailspamprotection.com [108.178.24.173])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D5F92C0096
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2012 03:40:01 +1100 (EST)
Received: from ns1.siteground150.com ([184.154.230.7]
 helo=serv01.siteground150.com)
 by se3.mailspamprotection.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.80) (envelope-from <gmane@reliableembeddedsystems.com>)
 id 1TPxZ8-0005uw-9d
 for linuxppc-dev@ozlabs.org; Sun, 21 Oct 2012 10:35:53 -0500
Message-ID: <50841653.4050301@reliableembeddedsystems.com>
Date: Sun, 21 Oct 2012 18:35:47 +0300
From: Robert Berger <gmane@reliableembeddedsystems.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com>
 <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
In-Reply-To: <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, mla@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 10/18/2012 10:03 PM, Benjamin Herrenschmidt wrote:
> 
> Which looks correct. So this might be something specific to ELDK ?

I just tried with the ELDK 5.2.1 and have exactly the same behavior as
with ELDK 4.2, so I guess there is something not correct in
arch/powerpc/sysdev/ppc4xx_msi.c.

Just to exclude the case that I'm doing something stupid which only
affects kernel versions 3.5+ and not 3.4 can someone else give it a try
with a kilauea board or something similar?

Regards,

Robert

> 
> Cheers,
> Ben.
> 

..."Serious programming is systems programming or anything beyond
writing factorial(n) as a student exercise." -- Brian W. Kernighan

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
