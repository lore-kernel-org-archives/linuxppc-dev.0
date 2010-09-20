Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 38316B70AB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 04:51:58 +1000 (EST)
Received: from mail54-tx2 (localhost.localdomain [127.0.0.1])	by
	mail54-tx2-R.bigfish.com (Postfix) with ESMTP id B3F931203EE	for
	<linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 18:51:55 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.241])	by
	mail54-tx2.bigfish.com (Postfix) with ESMTP id 3B530191805F	for
	<linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 18:51:41 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8KIpdsO008039	for
	<linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 11:51:39 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8KJ724k000977	for <linuxppc-dev@ozlabs.org>;
	Mon, 20 Sep 2010 14:07:02 -0500 (CDT)
Date: Mon, 20 Sep 2010 13:51:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
Message-ID: <20100920135136.04ceb772@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTi=RXjc=GZ+RRsKjL3qdYFayXOCX0s1SU5jojeXg@mail.gmail.com>
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
	<AANLkTi=RXjc=GZ+RRsKjL3qdYFayXOCX0s1SU5jojeXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 18 Sep 2010 14:22:12 -0400
Josh Boyer <jwboyer@gmail.com> wrote:

> Capitalizing?  The patch you posted that uses this symbol is for a GPL
> driver so you gain or lose nothing by having this symbol be
> EXPORT_SYMBOL_GPL.  Are you somehow advocating and getting some sort
> of gain by allowing non-GPL modules?  If so, I find that unfortunate.
> If not, then I guess I don't understand what you mean by capitalizing.

One can dislike DRM (even a very weak form such as this) without having
a particular desire to go outside the bounds of what it allows.

I thought EXPORT_SYMBOL_GPL was originally meant to indicate the
symbols whose use is likely to be indicitave of code that is, in some
copyright-meaningful way, derived from GPL code?  I have a hard time
seeing that being the case here.  If every symbol is made GPL-only,
then that just gives the binary-only people[1] more incentive to
circumvent the entire mechanism.  It loses its meaning.

Documentation/DocBook/kernel-hacking.tmpl says, "It implies that the
function is considered an internal implementation issue, and not really
an interface."

-Scott

[1] Plus anyone who might want to make a kernel module out of code
which is open source, but not under a license the GPLv2 is compatible
with.
