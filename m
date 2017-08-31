Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjP6V3N9LzDqR9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 10:54:58 +1000 (AEST)
Message-ID: <1504140897.4670.35.camel@neuling.org>
Subject: Re: [PATCH v3 00/17] powerpc: Do alignment fixups using
 analyse_instr etc.
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Thu, 31 Aug 2017 10:54:57 +1000
In-Reply-To: <1504140598.4670.32.camel@neuling.org>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
 <1504140598.4670.32.camel@neuling.org>
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

On Thu, 2017-08-31 at 10:49 +1000, Michael Neuling wrote:
> Tested-by: Michael Neuling <mikey@neuling.org>
>=20
> FWIW I've written a test case for alignment faults (which I'll convert to=
 a
> selftest and upstream). It tests all load stores supported by POWER9 (res=
ults
> below).

Sorry, this is not quite right.  It doesn't test load/store quad or string
instructions.

It also doesn't test atomic memory options (AMO) since they can't be emulat=
ed
anyway.

Mikey
