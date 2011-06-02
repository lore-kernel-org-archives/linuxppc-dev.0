Return-Path: <pochini@shiny.it>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
	by ozlabs.org (Postfix) with ESMTP id E1053B6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 08:06:52 +1000 (EST)
Date: Fri, 3 Jun 2011 00:00:12 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Andrey Gusev <ronne@list.ru>
Subject: Re: PROBLEM: 2.6.39 =?UTF-8?Q?doesn=E2=80=99t?= boot on POWER MAC
Message-ID: <20110603000012.4ce5c45f@Jay>
In-Reply-To: <4DE0AA62.4070909@list.ru>
References: <4DE0AA62.4070909@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 28 May 2011 11:55:14 +0400
Andrey Gusev <ronne@list.ru> wrote:

> Hi!
> A kernel 2.6.39 doesn't boot on my POWER MAC G4.

Same problem with my dual-G4 MDD. A few more infos:
The machine hangs just after the message "Returning from prom_init" (still
in the OF screen).
The kernel works fine with the option maxcpus=1, but it locks up as soon as
I try to enable the second CPU with echo 1 > /sys.../online.


-- 
Giuliano.
