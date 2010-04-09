Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49856B7D00
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Apr 2010 15:44:07 +1000 (EST)
Subject: Re: Ethernet support missing p1020rdb.dts
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4BBDB59C.4050402@embedded-sol.com>
Date: Fri, 9 Apr 2010 00:43:50 -0500
Message-Id: <972C2D0A-EE3F-4183-998C-E1763D46DBE4@kernel.crashing.org>
References: <4BBDB59C.4050402@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 8, 2010, at 5:53 AM, Felix Radensky wrote:

> Hi,
>=20
> I've just noticed that ethernet nodes are missing in p1020rdb device =
tree.
> Are there any known problems with ethernet controllers on p1020rdb ?

I'd say its not problems, its support for the newer controller on =
p1020rdb.  At the time the .dts the kernel didn't have support.  I'm not =
100% clear on its current state.

- k=
