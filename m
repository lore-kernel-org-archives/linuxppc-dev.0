Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 79B1BB70E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 03:00:43 +1000 (EST)
Received: from mail101-tx2 (localhost.localdomain [127.0.0.1])	by
	mail101-tx2-R.bigfish.com (Postfix) with ESMTP id 9CE861A881E0	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 17:00:23 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.250])	by
	mail101-tx2.bigfish.com (Postfix) with ESMTP id 9B3C31A40052	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 17:00:22 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8LH0JWW016245	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 10:00:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8LHFjG3006418	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 12:15:45 -0500 (CDT)
Date: Tue, 21 Sep 2010 12:00:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
Subject: Re: Generating elf kernel ?
Message-ID: <20100921120017.220db783@udp111988uds.am.freescale.net>
In-Reply-To: <52CF90264091A14888078A031D780F4306C8BD2F@ism-mail03.corp.ad.wrs.com>
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<20100914125713.GB5768@radix50.net>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
	<4C90835E.4050803@windriver.com>
	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
	<4C9182EC.5030900@windriver.com>
	<20100916120944.11c45c31@schlenkerla.am.freescale.net>
	<4C92CB51.5010008@windriver.com>
	<20100917124448.255b08cc@schlenkerla.am.freescale.net>
	<4C9569FF.6090807@windriver.com>
	<20100920104353.5dbd9201@udp111988uds.am.freescale.net>
	<52CF90264091A14888078A031D780F4306C8BD2F@ism-mail03.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2010 03:00:40 +0200
"Chen, Tiejun" <Tiejun.Chen@windriver.com> wrote:

> This should be depend on the hypervisor design implementation. I think
> your 
> option should be based on the Freescale hypervisor.

Again, I was giving an example, about ELF loading.  I was not making any
claims about what all hypervisors do. :-P

-Scott
