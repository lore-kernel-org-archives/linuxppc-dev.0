Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytVQD3gzlzDrVJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 22:25:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Desnes Augusto Nunes do =?utf-8?Q?Ros=C3=A1rio?=
 <desnesn@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, amodra@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, ard.biesheuvel@linaro.org,
 rusty@rustcorp.com.au
Subject: Re: [PATCH] [powerpc-next] Fix powerpc64 alignment of .toc section in
 kernel modules
In-Reply-To: <dd057271-5ee1-26b5-c7a7-a594940c2920@linux.vnet.ibm.com>
References: <20171206191228.30830-1-desnesn@linux.vnet.ibm.com>
 <877etylo6i.fsf@concordia.ellerman.id.au>
 <dd057271-5ee1-26b5-c7a7-a594940c2920@linux.vnet.ibm.com>
Date: Fri, 08 Dec 2017 22:25:23 +1100
Message-ID: <87o9n9h36k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Desnes Augusto Nunes do Ros=C3=A1rio <desnesn@linux.vnet.ibm.com> writes:
...
>
> Lastly, will you fix it up or do you want me to send a second version=20
> then? Whatever is best for you.

No that's fine I've done those changes, no need to send another version.

cheers
