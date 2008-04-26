Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C15C9DDE06
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 09:10:51 +1000 (EST)
Subject: Re: sysfs cpu entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <4811593B.8080508@hypersurf.com>
References: <4811593B.8080508@hypersurf.com>
Content-Type: text/plain
Date: Sun, 27 Apr 2008 09:10:30 +1000
Message-Id: <1209251430.5420.44.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-24 at 21:08 -0700, Kevin Diggs wrote:
> P.S.:  On an unrelated note, anyone know where to start looking for
> problems in pmac_zilog. My 8600 modem which worked fine in 2.4 is now
> essentially useless. Some problem with handshaking, I think.

It's possible that handshaking is broken, I remember some nasty tricks
with it on some Apple HW and I may have gotten that wrong... 

Ben.
