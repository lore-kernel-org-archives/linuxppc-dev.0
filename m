Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E496DDE41
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 11:57:02 +1000 (EST)
Subject: Re: Interrupt routing broken on TiBook IV with 2.6.21.x ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian =?ISO-8859-1?Q?B=F6hme?= <monodhs@gmx.de>
In-Reply-To: <4650E27B.3020401@gmx.de>
References: <4650E27B.3020401@gmx.de>
Content-Type: text/plain
Date: Mon, 21 May 2007 11:56:54 +1000
Message-Id: <1179712614.32247.597.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Has anyone any idea what causes the audio output to die prematurely ?

Nope... it can't be a routing problem since interrupt -is- routed (you
are getting it !) unless I missed some subtle breakage in the
device-tree.

Which exact tipb model is this ? (cat /proc/device-tree/model)

Cheers,
Ben.
