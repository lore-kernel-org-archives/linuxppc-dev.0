Return-Path: <srs0=izxq=bt=aculab.com=david.laight@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJRHD5jMLzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 00:20:08 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yJRHD4ZHbz8vmR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 00:20:08 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Breno Leitao' <leitao@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "mikey@neuling.org"
 <mikey@neuling.org>, "cyrilbur@gmail.com" <cyrilbur@gmail.com>
Subject: RE: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
Date: Fri, 20 Oct 2017 12:58:39 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD009D7D7@AcuExch.aculab.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
In-Reply-To: <20171020114539.piyh4wmby5gz7qnb@gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > This patch adds a simple commandline option so that HTM can be
> > disabled at boot time.

ISTM that being able to disable it after boot would be more useful.
(ie in a startup script)

	David
