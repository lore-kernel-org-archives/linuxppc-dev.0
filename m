Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBgYl18njzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 15:12:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/modules: Use WARN_ON() in stub_for_addr()
In-Reply-To: <1507646852-18642-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1507646852-18642-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 15:12:42 +1100
Message-ID: <87d15uz5j9.fsf@concordia.ellerman.id.au>
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

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:

> Use WARN_ON(), while running out of stubs in stub_for_addr()
> and abort loading of the module instead of BUG_ON().

Thanks. This looks good in principle. Have you actually tested it to
make sure we do in fact gracefully fail the module load?

cheers
