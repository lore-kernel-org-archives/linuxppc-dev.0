Return-Path: <stelios@stelioscellar.com>
Received: from smtp01.vivodinet.gr (smtp06out.vivodinet.gr [83.171.203.6])
	by ozlabs.org (Postfix) with ESMTP id 12ED767C1D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Oct 2006 05:37:56 +1000 (EST)
Received: from dias (dslcustomer169.vivodi.gr [80.76.56.169])
	by smtp01.vivodinet.gr (8.12.10/8.12.10) with SMTP id k9EJbYWB028924
	for <linuxppc-embedded@ozlabs.org>; Sat, 14 Oct 2006 22:37:35 +0300
From: "Stelios Koroneos" <stelios@stelioscellar.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Gofast float point and 405ep
Date: Sat, 14 Oct 2006 22:37:34 +0300
Message-ID: <HOECLKEKOHLAMMGDLLBHCENLHOAA.stelios@stelioscellar.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <45311FE5.3080400@cs.york.ac.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings !

Has anyone used the Gofast float point lib instead of the gcc one with the
405?
If yes have you measured significant differences in performance ?

I need to do considerable floating point operations (dtmf detection, echo
cancelation etc) and i was wondering if there are any speed improvents

Stelios
