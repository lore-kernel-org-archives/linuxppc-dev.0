Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 72AD3DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 05:40:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: settimeofday not working
Date: Thu, 25 Oct 2007 14:40:28 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B038A269F@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I upgraded my board-port from 2.6.18 (8280 in arch/ppc) to 2.6.23 (Yes,
I know, arch/powerpc. I am planning on doing that, I just wanted the old
stuff working first).

On any kernel newer than 2.6.20, settimeofday does not work.
I try to set the current date, but when I read back the time, it is
still the old date (in our case, Jan 1 1970)

Any idea of where I should start looking?
