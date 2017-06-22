Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtf7T0P9BzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 21:12:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/6] powerpc/64s: Blacklist functions invoked on a trap
In-Reply-To: <20170622134446.2daf569c@roar.ozlabs.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <0ddd4186e9044e5fa7079a6b5bb30aa885957142.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622134446.2daf569c@roar.ozlabs.ibm.com>
Date: Thu, 22 Jun 2017 21:12:36 +1000
Message-ID: <8760fos2cb.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 22 Jun 2017 00:08:41 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>
>> Blacklist all functions involved while handling a trap. We:
>> - convert some of the symbols into private symbols,
>> - remove the duplicate 'restore' symbol, and
>> - blacklist most functions involved while handling a trap.
>
> I'm not sure removing "restore" makes it better. 

Yeah it bloats the patch needlessly, we can do a rename patch later.

cheers
