Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id DBD77B70A8
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Sep 2010 04:22:14 +1000 (EST)
Received: by wwi18 with SMTP id 18so888283wwi.21
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Sep 2010 11:22:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5610599F537DD74A8D1F5CC946A75073034792F9@az33exm25.fsl.freescale.net>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
	<AANLkTinidrifo3ry7o=DPKF96f3o4+_2zt7rsn=Zvh9D@mail.gmail.com>
	<1284779678.30449.108.camel@pasglop>
	<AC849F1A-BC8A-4705-90E0-26991FAE6EED@freescale.com>
	<70810686-1EB6-4AD9-A89B-C2A8BA6AC30D@freescale.com>
	<AANLkTi=sa1LJOnw4fK-fX23Egxm7NoJVNKB1vtc9Eg4q@mail.gmail.com>
	<5610599F537DD74A8D1F5CC946A75073034792F7@az33exm25.fsl.freescale.net>
	<AANLkTimSewEEhbBoBb+fpPgY9EbE5bWsknPS7OkQgkcy@mail.gmail.com>
	<5610599F537DD74A8D1F5CC946A75073034792F9@az33exm25.fsl.freescale.net>
Date: Sat, 18 Sep 2010 14:22:12 -0400
Message-ID: <AANLkTi=RXjc=GZ+RRsKjL3qdYFayXOCX0s1SU5jojeXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
From: Josh Boyer <jwboyer@gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 18, 2010 at 1:55 PM, Tabi Timur-B04825 <B04825@freescale.com> w=
rote:
> Josh Boyer wrote:
>> This is a new symbol being exported, not
>> one that has been exported for years.
>
> Except that Ben says that I should change ppc_proc_freq from EXPORT_SYMBO=
L
> to
> EXPORT_SYMBOL_GPL as well.=A0 In a sense, we're in a catch-22.=A0 We have=
 three
> choices:
>
> 1. We *arbitrarily* change ppc_proc_freq from EXPORT_SYMBOL to
> EXPORT_SYMBOL_GPL, so that the two symbols are exported the same way
>
> 2. We GPL-export only ppc_tb_freq and leave ppc_proc_freq as-is, but then=
 it
> looks dumb.

I dunno.  I don't think it looks dumb.  It could mean nothing more
than we were paying closer attention this time.

> 3. We export ppc_tb_freq the same way we're exporting ppc_proc_freq,
> providing the most options and maintaining consistency.
>
> I just don't see how options #1 or #2 are better than #3, and so far the
> only
> explanations I've heard are along the lines of "we just like it that way"=
.

Now I think I've been a bit more detailed than that.  I at least
explained why I prefer it that way.  If you disagree, that's fine but
don't make me sound like some kind of petulant child.

> Obviously, Linus thinks it's okay to allow some non-GPL modules, otherwis=
e
> he
> would have long ago changed all EXPORT_SYMBOLs to EXPORT_SYMBOL_GPL.=A0 I=
'm
> just capitalizing on that mindset.

Capitalizing?  The patch you posted that uses this symbol is for a GPL
driver so you gain or lose nothing by having this symbol be
EXPORT_SYMBOL_GPL.  Are you somehow advocating and getting some sort
of gain by allowing non-GPL modules?  If so, I find that unfortunate.
If not, then I guess I don't understand what you mean by capitalizing.

josh
