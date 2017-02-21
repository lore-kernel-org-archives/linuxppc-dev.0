Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSZxT1zddzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:32:13 +1100 (AEDT)
Message-ID: <1487716298.23576.197.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Allow configurable stack size (especially 32k on
 PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>, Hamish Martin
 <hamish.martin@alliedtelesis.co.nz>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Feb 2017 09:31:38 +1100
In-Reply-To: <20170221125100.GA12237@visitor2.iram.es>
References: <20170220202440.25796-1-hamish.martin@alliedtelesis.co.nz>
 <20170221125100.GA12237@visitor2.iram.es>
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

On Tue, 2017-02-21 at 13:51 +0100, Gabriel Paubert wrote:
> For now it has only been used for little-endian kernel and
> applications,
> but according to messages that I have seen on the list, switching the
> kernel 
> to Elf V2 should be possible.

I don't think the toolchain "supports" ELFv2 on BE. It sort-of seems to
work but it's not supported.

Cheers,
Ben.
