Return-Path: <maz@misterjones.org>
Date: Tue, 9 Sep 2008 22:08:55 +0200
From: Marc Zyngier <maz@misterjones.org>
To: =?UTF-8?B?Um9nw6lyaW8=?= Brito <rbrito@ime.usp.br>
Subject: Re: Call Trace and scary messages on kernel 2.6.27-rc5
Message-ID: <20080909220855.658b967c@why>
In-Reply-To: <20080909004727.GA6239@ime.usp.br>
References: <20080909004727.GA6239@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Sep 2008 21:47:29 -0300
Rog=C3=A9rio Brito <rbrito@ime.usp.br> wrote:

> Hi there.
>=20
> I just compiled a new 2.6.27-rc5 kernel for my standard Kurobox (an
> embedded NAS that has an MPC8241 CPU, if I'm not mistaken) and upon
> booting, I get these scary messages and Call Traces:

[snip]

This is a known problem.

Check patch bb23b431db7405f6d79f989ad0236bf6428ba1cb in Linus' tree, it
should correct the traces you see.

Regards,

	M.
--=20
And if you don't know where you're going, any road will take you there.
