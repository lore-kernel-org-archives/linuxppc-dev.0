Return-Path: <srs0=ihzl=iz=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411wv40CJ8zF35k
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 05:43:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 411wv36YPGz8tV7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 05:43:11 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 411wv22pkRz9s1B
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2018 05:43:08 +1000 (AEST)
Date: Thu, 7 Jun 2018 21:43:03 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/4] powerpc/pseries: Machien check handler
 improvements.
Message-ID: <20180607214303.70d9bc6f@kitsune.suse.cz>
In-Reply-To: <152825972491.24560.4626614298142965406.stgit@jupiter.in.ibm.com>
References: <152825972491.24560.4626614298142965406.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 06 Jun 2018 10:06:23 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> This patch series includes some improvement to Machine check handler
> for pseries. Patch 1 fixes an issue where machine check handler
> crashes kernel while accessing vmalloc-ed buffer while in nmi context.
> Patch 3 dumps the SLB contents on SLB MCE errors to improve the
> debugability. Patch 4 display's the MCE error details on console.
>=20
> ---
>=20
> Mahesh Salgaonkar (4):
>       powerpc/pseries: convert rtas_log_buf to linear allocation.
>       powerpc/pseries: Define MCE error event section.
>       powerpc/pseries: Dump and flush SLB contents on SLB MCE errors.
>       powerpc/pseries: Display machine check error details.

Tested-by: Michal Such=C3=A1nek <msuchanek@suse.de>

Thanks

Michal
