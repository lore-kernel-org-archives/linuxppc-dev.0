Return-Path: <MBenedict@twacs.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3573EDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 04:51:44 +1000 (EST)
Received: from outbound1-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-fra-R.bigfish.com (Postfix) with ESMTP id 128928E3D36
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 18:51:35 +0000 (UTC)
Received: from mail26-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound1-fra.bigfish.com (Postfix) with ESMTP id 10A93570001
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 18:51:35 +0000 (UTC)
Received: from mail26-fra (localhost.localdomain [127.0.0.1])
	by mail26-fra-R.bigfish.com (Postfix) with ESMTP id 73ADE408589
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 18:51:41 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail26-fra.bigfish.com (Postfix) with ESMTP id C29F1D008B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 18:51:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: futex priority based wakeup
Date: Mon, 10 Sep 2007 13:51:32 -0500
Message-ID: <BAF8B1E0BB28024A90895E746A3B610D1C2BE3@twx-exch01.twacs.local>
In-Reply-To: <000e01c7f177$05ab1990$3a0d10ac@Radstone.Local>
References: <BAF8B1E0BB28024A90895E746A3B610D1C2BD7@twx-exch01.twacs.local>
	<000e01c7f177$05ab1990$3a0d10ac@Radstone.Local>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ilya Lipovsky wrote:
> Yes, I am uncertain. If it isn't a major headache, I think
> you can try the
> newest version (I think it's 2.6.1) and see if you get some
> resolution.=20
<snip>
> Please do share the outcome!!
>=20
> -Ilya

No luck with 2.6.1:

~ $ /lib/libc.so.6
GNU C Library stable release version 2.6.1, by Roland McGrath et al.
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.1.1.
Compiled on a Linux 2.6.12 system on 2007-09-10.
Available extensions:
        crypt add-on version 2.1 by Michael Glad and others
        Native POSIX Threads Library by Ulrich Drepper et al
        BIND-8.2.3-T5B
For bug reporting instructions, please see:
<http://www.gnu.org/software/libc/bugs.html>.
~ $ ./bar
unimportant waiting for mutex
important waiting for mutex
main unlocking mutex
unimportant got mutex!
important got mutex!


I will continue investigating and follow up on this thread if I come
across anything.
	-Michael
