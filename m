Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9BC9567BB0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 09:52:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7LNqjW8004051
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 19:52:45 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7LNqjkQ280796
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 19:52:45 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7LNqiR7004012
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 19:52:45 -0400
Date: Mon, 21 Aug 2006 18:52:44 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
Message-ID: <20060821235244.GJ5427@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
	<200608190256.26373.arnd@arndb.de> <44E7BB7F.7030204@osdl.org>
	<200608191325.19557.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608191325.19557.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
	Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>,
	Stephen Hemminger <shemminger@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 19, 2006 at 01:25:18PM +0200, Arnd Bergmann wrote:
> 
> What is the best way to treat the IRQ mask for TX interrupts?
> I guess it should be roughly:
> 
> - off when we expect ->poll() to be called, i.e. after calling
>   netif_rx_schedule() or returning after a partial rx from poll().

Under what circumstance does one turn TX interrupts back on?
I couldn't quite figure that out.

--linas
