Return-Path: <andrea.rosetti@hse-systems.com>
Received: from nexus.dnshighspeed.com (nexus.dnshighspeed.com [212.239.26.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B9E6DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jul 2007 13:14:45 +1000 (EST)
Received: from hsesyste by nexus.dnshighspeed.com with local (Exim 4.63)
	(envelope-from <andrea.rosetti@hse-systems.com>) id 1I5dnc-0002ZO-Oy
	for linuxppc-embedded@ozlabs.org; Tue, 03 Jul 2007 10:31:52 +0200
Message-ID: <1247.85.43.48.190.1183451512.squirrel@www.hse-systems.com>
Date: Tue, 3 Jul 2007 10:31:52 +0200 (CEST)
Subject: A uart driver to control modem
From: "Andrea Rosetti" <andrea.rosetti@hse-systems.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Reply-To: andrea.rosetti@hse-systems.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi everybody,

I'm a newbe on linux emb development.
In a mpc880 based board (kernel 2.6.19) I've to control a modem
using a scc with handshake signals on general I/O ports.
Reading code of cpm_uart driver, it seems don't manage
handshake signals whereas uart driver (<2.6.10) seems do this.
It's correct?
Could you suggest the right way to start?

Thank you,
Andrea

-- 
H.S.E. Systems
Smartcard & Loyalty Solutions
G. Di Vincenzo, 2
67100 - L'Aquila - Italy
Tel.  08621965154
Mobile 3406874961
Fax 0862319822
