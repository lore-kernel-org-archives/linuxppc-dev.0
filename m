Return-Path: <ppclinux@sundmangroup.com>
Received: from smtp1.uniweb.no (smtp1.uniweb.no [195.159.128.247])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4C03686B5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Nov 2005 03:00:42 +1100 (EST)
Message-ID: <35107.194.237.142.7.1131292443.squirrel@webmail1.unisite.se>
Date: Sun, 6 Nov 2005 16:54:03 +0100 (CET)
From: ppclinux@sundmangroup.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Subject: RAISE OF PRIORITY?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
Does anyone of you know if there are any problems involved in raising the
priority of a SCHED_OTHER thread to SCHED_RR and then lower it back to
SCHED_OTHER?

Regards // Matias
