Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kn.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DA7ADDDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 05:38:12 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kn.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	l6QJD5o27862
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 19:13:05 GMT
Message-ID: <46A8F22E.6010701@nortel.com>
Date: Thu, 26 Jul 2007 13:12:46 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: help with ppc sections?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

I'm porting kprobes to 2.6.14, and I think I've got it mostly done.  The 
last thing that I want to do is to mark flush_icache_range() as part of 
the .kprobes.text section so that we don't accidently try to probe it.

On ppc64 this was done by duplicating the _GLOBAL macro and just 
modifying the ".section" line.

Unfortunately for me, ppc doesn't have a ".section" line in that macro, 
so I'm at a bit of a loss.

Anyone got any suggestions, or pointers on where I could read up on it?

Chris
