Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F3EDDE1E8
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:03:22 +1100 (EST)
Received: from sullivan.realtime.net (localhost [127.0.0.1])
	by sullivan.realtime.net (8.13.1/8.9.3) with ESMTP id l2LF3Jsq008532
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 09:03:19 -0600 (CST)
	(envelope-from miltonm@sullivan.realtime.net)
Received: (from miltonm@localhost)
	by sullivan.realtime.net (8.13.1/8.12.7/Submit) id l2LF3JRS008531
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 09:03:19 -0600 (CST)
Date: Wed, 21 Mar 2007 09:03:19 -0600 (CST)
Message-Id: <200703211503.l2LF3JRS008531@sullivan.realtime.net>
Subject: Re: [PATCH 1/4] powerpc: Add gcc format warnings to zImage printf()
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070321063149.ED879DDE47@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


+extern int sprintf(char *buf, const char *fmt, ...) __attribute__((format(printf, 2, 3)));

you exceeded 80 columns by 10.

milton
