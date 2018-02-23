Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znqnZ4Js5zF1k6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:11:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org, greg@kroah.com
Cc: npiggin@gmail.com, linuxppc-dev@ozlabs.org, linux@roeck-us.net,
 corsac@debian.org
Subject: Re: [PATCH v4.4 backport 2/3] powerpc/64s: Simple RFI macro
 conversions
In-Reply-To: <20180222123545.8946-2-mpe@ellerman.id.au>
References: <20180222065738.GB2428@kroah.com>
 <20180222123545.8946-1-mpe@ellerman.id.au>
 <20180222123545.8946-2-mpe@ellerman.id.au>
Date: Fri, 23 Feb 2018 23:11:12 +1100
Message-ID: <87606nq527.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> Subject: [PATCH v4.4 backport 2/3] powerpc/64s: Simple RFI macro conversions
                     ^
                   4.9

Gah, sorry just realised these last two have "v4.4" in the subject, but
it should be "4.9".

cheers
