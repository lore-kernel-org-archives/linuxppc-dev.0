Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from lists.sandelman.ca (cod.sandelman.ca [192.139.46.139])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lists.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 38B73684FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 03:46:51 +1000 (EST)
Received: from sandelman.ottawa.on.ca
	(CPE0080c8d59fa8-CM0011aea1b6fc.cpe.net.cable.rogers.com
	[69.196.216.20])
	by lists.sandelman.ca (8.11.6p3/8.11.6) with ESMTP id j97HkgG04448
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified
	OK)
	for <linuxppc-embedded@ozlabs.org>; Fri, 7 Oct 2005 13:46:48 -0400 (EDT)
Received: from marajade.sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 4C61BE9955
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 13:46:42 -0400 (EDT)
To: linuxppc-embedded@ozlabs.org
In-Reply-To: Message from "Michael Richardson" <mcr@sandelman.ottawa.on.ca>
	of "Fri, 07 Oct 2005 13:15:28 EDT."
	<19942.1128705328@marajade.sandelman.ottawa.on.ca>
References: <19942.1128705328@marajade.sandelman.ottawa.on.ca> 
Date: Fri, 07 Oct 2005 13:46:42 -0400
Message-ID: <21062.1128707202@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Subject: Re: stepping through atomic_dec_return 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Michael" == Michael Richardson <mcr@sandelman.ottawa.on.ca> writes:
    Michael> I can see how setting through this code with the debugger
    Michael> could cause a problem, since there would be debug
    Michael> exceptions, and there would be other code in the debug
    Michael> stubs that could set the RESERVED=0.  It's hard to know,
    Michael> but it seems unlikely to me.

  Actually, I'm wrong. 
  I was trying to single step through the code, since much of the code
is inline, and doing "n" in the debugger won't set a break point after
that statement, it may well single step through.
  Setting a break point after the down() worked.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQ0a0f4qHRg3pndX9AQHs7AP+NVMj0Wy3aT9j1XW6t2hZqgjzVZZpAFuV
8b6hPtMVh/SYv6KbdWD4EmxQ7WMqB1rmx6oknxo6l7zTKHFwqmeW3Nod7X/xhNjy
SW4H8U/y7RjuI68i0rf1jkpUff6+3prKRvnVQ6dml7xH6IygBqDHjVP2hZlut++3
l30N1y5x1mU=
=d/sP
-----END PGP SIGNATURE-----
