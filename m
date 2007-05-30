Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF43CDE006
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 May 2007 07:53:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: sys_futex
Date: Wed, 30 May 2007 14:53:25 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A219@MERCURY.inside.istor.com>
In-Reply-To: <fa686aa40705291125m2096b198yba60c38f048c1cbb@mail.gmail.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Linux PPC" <linuxppc-embedded@ozlabs.org>
Cc: Kevin Smith <ksmith@istor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a user space application to kernel interface question. We are
using linux-2.6.17.11 in our design and have two boards. One 8241 and
one 8541.

In user space, we need to use the system call "sys_futex", but when the
user space application is compiled we have an unresolved linkage error.

Can someone offer a suggestion on the care and feeding of "sys_futex" in
a ppc 8241/8541 environment.

Thanks.
