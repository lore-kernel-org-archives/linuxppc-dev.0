Return-Path: <CFRIESEN@nortel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 905CAB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 07:48:34 +1000 (EST)
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B1093DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 07:48:33 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	n69LKLi14057
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2009 21:20:22 GMT
Message-ID: <4A565EEB.9020607@nortel.com>
Date: Thu, 09 Jul 2009 15:19:39 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: question on powerpc pthread mutexes and memory barriers
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi all,

This probably isn't the right place to ask about this, but does anyone
know where the implied memory barrier happens for pthread mutexes in the
uncontended case?  I'm looking at the glibc code and I don't see any
barrier instructions for mutexes, only semaphores and spinlocks.

Thanks,

Chris
