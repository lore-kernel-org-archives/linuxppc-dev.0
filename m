Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssmyd4P05zDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 15:16:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: sysrq-b fails miserably to reboot PowerNV box
In-Reply-To: <20161008221656.5f6dadb5@kryten>
References: <20161008221656.5f6dadb5@kryten>
Date: Mon, 10 Oct 2016 15:16:09 +1100
Message-ID: <87a8ec7sae.fsf@concordia.ellerman.id.au>
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

Anton Blanchard <anton@samba.org> writes:

> Hi,
>
> Unfortunately sysrq-b seems to tie us up in knots, instead of rebooting
> the box. This is mainline from today.

I logged it too, so we (hopefully) don't forget:

  https://github.com/linuxppc/linux/issues/72


cheers
