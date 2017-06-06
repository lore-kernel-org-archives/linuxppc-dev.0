Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj4gY1msDzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 07:33:45 +1000 (AEST)
Subject: Re: [PATCH 08/16] powerpc: ps3: use dev_groups and not dev_attrs for
 bus_type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-9-gregkh@linuxfoundation.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <797417fc-87f4-597b-ec10-ce73fef34320@infradead.org>
Date: Tue, 6 Jun 2017 14:33:21 -0700
MIME-Version: 1.0
In-Reply-To: <20170606192221.1617-9-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2017 12:22 PM, Greg Kroah-Hartman wrote:
> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.

>  arch/powerpc/platforms/ps3/system-bus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Seems OK.

-Geoff
