Return-Path: <shemminger@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DF3A567C12
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 06:41:07 +1000 (EST)
Date: Mon, 21 Aug 2006 13:40:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: NAPI documentation
Message-ID: <20060821134053.7225987b@dxpl.pdx.osdl.net>
In-Reply-To: <200608201948.20596.arnd@arndb.de>
References: <20060818220700.GG26889@austin.ibm.com> <44E7BB7F.7030204@osdl.org>
	<200608191325.19557.arnd@arndb.de>
	<200608201948.20596.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, Linas,
	Jeff Garzik <jgarzik@pobox.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I took this opportunity to get a start on improving NAPI documentation.
I mashed together the short text about NAPI (with permission) from lwn.net
and the existing NAPI-HOWTO, to make a page on the Linux net wiki.

I took the liberty of removing some of the bits that were out of date, or referred
to old Becker code. It still needs lots of editing to be presentable.

Please edit and improve
	http://linux-net.osdl.org/index.php/NAPI

When the page is in good shape, I will de-wiki it to place in kernel doc tree.
