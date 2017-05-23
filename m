Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wX29X1tkLzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 14:09:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of
 whole rewrite
In-Reply-To: <20170519154705.10504-1-ivan@de.ibm.com>
References: <87wp9d5ekz.fsf@concordia.ellerman.id.au>
 <20170519154705.10504-1-ivan@de.ibm.com>
Date: Tue, 23 May 2017 14:09:46 +1000
Message-ID: <87lgpo8b91.fsf@concordia.ellerman.id.au>
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

Ivan Mikhaylov <ivan@de.ibm.com> writes:
>
> From my point of view it's possible. I've checked docu and on idea
> it should be possible cause WP is only affecting watchdog ping time.

The question is, is there any chance that leaving those bits set on
another platform will cause a problem?

ie. on existing machines we always clear those bits, is it OK that we
will now start leaving those bits with whatever value they had.

cheers
