Return-Path: <weo@reccoware.de>
Received: from schu.reccoware.net (schu.reccoware.net [87.106.213.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXcKb15jdzDqHC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 22:48:34 +1100 (AEDT)
Received: from localhost (jodystroud.reccoware.net [82.165.160.205])
 (authenticated bits=0)
 by schu.reccoware.net (8.13.8/8.13.8/Recconet-2012062401) with ESMTP id
 v1SBlUCT001563
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:47:30 +0100
Message-ID: <1488282451.2358.9.camel@reccoware.de>
Subject: Re: [bug report] v4.10.1 Oops on P1010 - huge tlb - there's already
 a fix ...
From: Wolfgang Ocker <weo@reccoware.de>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Feb 2017 12:47:31 +0100
In-Reply-To: <1488275851.2358.4.camel@reccoware.de>
References: <1488275851.2358.4.camel@reccoware.de>
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

On Tue, 2017-02-28 at 10:57 +0100, Wolfgang Ocker wrote:
> With kernel v4.10.1 and huge tlb enabled (CONFIG_HUGETLBFS=y) I see
> the
>  following oops on a P1010:

Just saw that there is already a fix:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/154204.html

Thanks!
