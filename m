Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE3AEB6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 12:41:46 +1000 (EST)
Subject: Re: PROBLEM: 2.6.39 =?UTF-8?Q?doesn=E2=80=99t?= boot on POWER MAC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
In-Reply-To: <20110603000012.4ce5c45f@Jay>
References: <4DE0AA62.4070909@list.ru>  <20110603000012.4ce5c45f@Jay>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 03 Jun 2011 12:41:31 +1000
Message-ID: <1307068891.23876.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andrey Gusev <ronne@list.ru>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-03 at 00:00 +0200, Giuliano Pochini wrote:
> On Sat, 28 May 2011 11:55:14 +0400
> Andrey Gusev <ronne@list.ru> wrote:
> 
> > Hi!
> > A kernel 2.6.39 doesn't boot on my POWER MAC G4.
> 
> Same problem with my dual-G4 MDD. A few more infos:
> The machine hangs just after the message "Returning from prom_init" (still
> in the OF screen).
> The kernel works fine with the option maxcpus=1, but it locks up as soon as
> I try to enable the second CPU with echo 1 > /sys.../online.

I just verified that current upstream 3.0-rc1+ does boot fine.

Cheers,
Ben.
