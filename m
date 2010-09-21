Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id F0FADB6EEB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 22:50:24 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1Oy243-00055U-TI
	for linuxppc-dev@ozlabs.org; Tue, 21 Sep 2010 14:35:15 +0200
Received: from p4ff05920.dip.t-dialin.net ([79.240.89.32])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 14:35:15 +0200
Received: from dzu by p4ff05920.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 14:35:15 +0200
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
	reference it
Date: Tue, 21 Sep 2010 14:34:58 +0200
Message-ID: <m2d3s7w9zh.fsf@ohwell.denx.de>
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
	<20100920135136.04ceb772__36164.799918379$1285008751$gmane$org@udp111988uds.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

> On Sat, 18 Sep 2010 14:22:12 -0400
> Josh Boyer <jwboyer@gmail.com> wrote:
>
>> Capitalizing?  The patch you posted that uses this symbol is for a GPL
>> driver so you gain or lose nothing by having this symbol be
>> EXPORT_SYMBOL_GPL.  Are you somehow advocating and getting some sort
>> of gain by allowing non-GPL modules?  If so, I find that unfortunate.
>> If not, then I guess I don't understand what you mean by capitalizing.
>
> One can dislike DRM (even a very weak form such as this) without having
> a particular desire to go outside the bounds of what it allows.
>
> I thought EXPORT_SYMBOL_GPL was originally meant to indicate the
> symbols whose use is likely to be indicitave of code that is, in some
> copyright-meaningful way, derived from GPL code?  

Google finds this, which coincides with what I remmber[1]:

  EXPORT_SYMBOL_GPL 
  
  Some kernel developers are unhappy with providing external interfaces to
  their code, only to see those interfaces being used by binary only
  modules. They view it as their work being appropriated. Whether you
  agree with that view or not is completely irrelevant, the person who
  owns the copyright decides how their work can be used.
  
  EXPORT_SYMBOL_GPL() allows for new interfaces to be marked as only
  available to modules with a GPL compatible license. This is independent
  of the kernel tainting, but obviously takes advantage of
  MODULE_LICENSE() strings.
  
  EXPORT_SYMBOL_GPL() may only be used for new exported symbols, Linus has
  spoken. I believe the phrase involved killer penguins with chainsaws for
  anybody who changed existing exported interfaces.

Cheers
  Detlev

[1] http://lkml.indiana.edu/hypermail/linux/kernel/0110.2/0369.html
  
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
