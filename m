Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7WL14h8lzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 11:51:37 +1100 (AEDT)
Message-ID: <1507251097.4686.73.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: P9 disabled suspend mode workaround
From: Michael Neuling <mikey@neuling.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Cyril Bur <cyrilbur@gmail.com>
Date: Fri, 06 Oct 2017 11:51:37 +1100
In-Reply-To: <CACPK8XeBEp-vRpU9v9VXN5x47WEycZ=gObpUBaf9xAdYc3ezrg@mail.gmail.com>
References: <20171005045516.26145-1-mikey@neuling.org>
 <CACPK8XeBEp-vRpU9v9VXN5x47WEycZ=gObpUBaf9xAdYc3ezrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > This patch blocks this from happening on POWER9 but sanity checking
> > sigcontexts passed in.
>=20
> Should 'but' say 'by'?

Thanks

Mikey
