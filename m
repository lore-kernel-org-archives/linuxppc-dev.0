Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0D6B5B7D08
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 06:14:04 +1100 (EST)
Subject: Re: Large physical address support on e500 platform
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <341686.17314.qm@web37606.mail.mud.yahoo.com>
Date: Tue, 19 Jan 2010 13:13:57 -0600
Message-Id: <DC402F23-C6B5-4F7E-B66D-F0AFCC298CEA@kernel.crashing.org>
References: <341686.17314.qm@web37606.mail.mud.yahoo.com>
To: Alex Dubov <oakad@yahoo.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 19, 2010, at 12:54 AM, Alex Dubov wrote:

> I'm working on an mpc8548 based board and recently I've encountered a
> problem, whereupon kernel crashed each time module loading is =
attempted. I
> traced the problem to the fact, that vmalloc_exec was setting =
incorrect
> page attributes on allocated pages. This, in turn, happened because I
> specified "Large physical address support" in the Kconfig, leading to
> CONFIG_PHYS_64BIT and friends being set.
>=20
> It appears that having this option set on e500 pulls in incorrect =
headers
> and otherwise not working. CPU, however, has support for 36b physical
> addressing, which qualifies as "Large physical address".
>=20
> So, the obvious question is, what is the current status of large =
physical
> address support on e500? Is it a problem in current git version or is =
it
> not ready yet?
>=20
> Thanks.

Its possible that we've broken module/vmalloc support with "Large =
physical addressing".  Its not something I've tried in a while.  What =
kernel/git SHA are you using.

- k=
