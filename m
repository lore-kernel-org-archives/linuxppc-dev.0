Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE3461A0E57
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 08:33:48 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0060.hostedemail.com
 [216.40.44.60])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 537A0140291
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 08:33:47 +1100 (AEDT)
Date: Mon, 7 Dec 2015 16:33:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: tracing: don't trace hcalls on offline CPUs
Message-ID: <20151207163343.0ea2f1bb@gandalf.local.home>
In-Reply-To: <1449522135.21036.11.camel@kernel.crashing.org>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
 <1448389419-5296-2-git-send-email-kda@linux-powerpc.org>
 <20151207155224.2a8d71dd@gandalf.local.home>
 <1449522135.21036.11.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 08 Dec 2015 08:02:15 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2015-12-07 at 15:52 -0500, Steven Rostedt wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TP_CONDITION(cpu_online(smp_processor_=
id())),
> > > + =20
>=20
> This should probably be some kind of __raw version though, hcalls can
> be called in contexts where the debug stuff in smp_processor_id() isn't
> safe (or preempt enabled).
>=20

OK, then that needs to be updated.

-- Steve
