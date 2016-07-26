Return-Path: <christophe.leroy@c-s.fr>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzQh63PnhzDqf5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 03:52:53 +1000 (AEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rzQh45kJ1z9t0X
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2016 03:52:51 +1000 (AEST)
Received: from localhost (unknown [192.168.12.234])
 by localhost (Postfix) with ESMTP id 3rzQgx38cYz9ttFP
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2016 19:52:45 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4K4E0fcSusTV for <linuxppc-dev@ozlabs.org>;
 Tue, 26 Jul 2016 19:52:45 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 3rzQgx2ZxCz9ttDr
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2016 19:52:45 +0200 (CEST)
Date: Tue, 26 Jul 2016 19:52:45 +0200
Message-ID: <20160726195245.Horde.xJWqCTeuxQeC7gAnGhJItg6@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: linuxppc-dev@ozlabs.org
Subject: _PAGE_PRESENT and _PAGE_ACCESSED
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In ppc8xx tlbmiss handler, we consider a page valid if both  
_PAGE_PRESENT and _PAGE_ACCESSED are set.
Is there any chance to have _PAGE_ACCESSED set and not _PAGE_PRESENT ?
Otherwise we could simplify the handler by considering the page valid  
only when _PAGE_ACCESSED is set

Christophe
