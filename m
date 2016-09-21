Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfK5v5vC4zDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 22:42:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 6/6] powerpc/boot: Add support for XZ compression
In-Reply-To: <1474345764-28038-7-git-send-email-oohall@gmail.com>
References: <1474345764-28038-1-git-send-email-oohall@gmail.com>
 <1474345764-28038-7-git-send-email-oohall@gmail.com>
Date: Wed, 21 Sep 2016 22:42:42 +1000
Message-ID: <87k2e58lvh.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:
> This patch adds an option to use XZ compression for the kernel image.
> Currently this is only enabled for PPC64 targets since the bulk of the
> 32bit platforms produce uboot images which do not use the wrapper.

For the benefit of the list, this is failing to boot on some machines.
Oliver is debugging it for me :)

cheers
