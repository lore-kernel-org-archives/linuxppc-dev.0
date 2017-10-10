Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB5sw3lWmzDr4x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 16:54:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, hbabu@us.ibm.com,
 nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/18] powerpc: Emulate paste instruction
In-Reply-To: <1507543253.16703.6.camel@neuling.org>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1507343298-27496-16-git-send-email-sukadev@linux.vnet.ibm.com>
 <1507543253.16703.6.camel@neuling.org>
Date: Tue, 10 Oct 2017 16:54:44 +1100
Message-ID: <87376ry2cb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> @ -1924,6 +1987,7 @@ struct ppc_emulated ppc_emulated =3D {
>> =C2=A0	WARN_EMULATED_SETUP(mfdscr),
>> =C2=A0	WARN_EMULATED_SETUP(mtdscr),
>> =C2=A0	WARN_EMULATED_SETUP(lq_stq),
>> +	WARN_EMULATED_SETUP(paste),
>
> You'll need to rebase this on powerpc/next as this has changed upstream.

I can handle that, it should be a trivial conflict.

cheers
