Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8CC3567BC1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 04:21:49 +1100 (EST)
Message-ID: <458036A8.8060907@am.sony.com>
Date: Wed, 13 Dec 2006 09:21:44 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Reeve Yang <yang.reeve@gmail.com>
Subject: Re: kgdb on mpc834x
References: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
In-Reply-To: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reeve Yang wrote:
> I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no
> patch for 2.6.14), but gdb client cannot connec to it. I turn on all
> necessary kernel hacking options. Our board is customized with
> MPC834x, can someoen who used kgdb to debug kernel on MPC834x help me
> out? Following are the message from linux boot and gdb client.

You might have better luck posting to the kgdb mailing list, as this problem
is not specific to your platform, nor to PPC:

  kgdb-bugreport@lists.sourceforge.net

-Geoff
