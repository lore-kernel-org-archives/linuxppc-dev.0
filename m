Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 554D4DDFEB
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 09:38:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8DNbnBD019037
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 19:37:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8DNbnn6199086
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 19:37:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8DNbm9J021716
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 19:37:49 -0400
Date: Sat, 13 Sep 2008 19:37:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
Message-ID: <20080913193712.526aac41@zod.rchland.ibm.com>
In-Reply-To: <1221328153.7675.25.camel@pasglop>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
	<1221328153.7675.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, prodyut hazarika <prodyuth@gmail.com>, wd@denx.de,
	dzu@denx.de, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 13 Sep 2008 10:49:13 -0700
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2008-09-11 at 09:57 -0700, prodyut hazarika wrote:
> 
> > You should mention an example of dedicated cases (eg. RAID).
> > I think this help should mention that for page size 256KB, you will
> > need to have a special version of binutils, since the ELF standard
> > mentions page sizes only upto 64KB.
> 
> He should also put a BIG FAT warning with 256K pages. Those will -not-
> work with most existing userspace. The maximum page size supported by
> the current userspace ABI is 64K as this is the alignment requirement of
> our toolchain for the various program sections.

I think that's been noted like 5 times now :)

josh
