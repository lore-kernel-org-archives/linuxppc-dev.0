Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLZnD61bFzDsSP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 20:04:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] mpc832x_rdb: fix of_irq_to_resource() error check
In-Reply-To: <1501379504.3739.4.camel@buserror.net>
References: <20170729195217.214940504@cogentembedded.com>
 <1501379504.3739.4.camel@buserror.net>
Date: Mon, 31 Jul 2017 20:04:47 +1000
Message-ID: <87h8xs6hxc.fsf@concordia.ellerman.id.au>
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

Scott Wood <oss@buserror.net> writes:

> On Sat, 2017-07-29 at 22:52 +0300, Sergei Shtylyov wrote:
>> of_irq_to_resource() has recently been=C2=A0=C2=A0fixed to return negati=
ve error #'s
>> along with 0 in case of failure,=C2=A0=C2=A0however the Freescale MPC832=
x RDB board
>> code still only regards 0 as as failure indication -- fix it up.
>>=20
>> Fixes: 7a4228bbff76 ("of: irq: use of_irq_get() in of_irq_to_resource()")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>=20
>> ---
>> The patch is against the 'master' branch of Scott Wood's 'linux.git' repo
>> (the 'fixes' branch is too much behind).
>
> The master branch is also old.  Those branches are only used when needed =
to
> apply patches; I don't update them just to sync up.  If they're older than
> what's in Michael's or Linus's tree (as they almost always are), then use
> those instead.
>
> Not that I expect it to make a difference to this patch...

Do you want me to grab this as a fix for 4.13 ?

cheers
