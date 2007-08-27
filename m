Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "zrtps0kp.nortel.com", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 48241DDE42
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 06:22:14 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com
	[47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	l7RKM8b02753
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 20:22:08 GMT
Message-ID: <46D3326C.3000505@nortel.com>
Date: Mon, 27 Aug 2007 14:22:04 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: what is ~1MB of memory allocated at fffea000-fffff000 on ppc64?
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

I've got a ppc64 box running 2.6.14.  64-bit kernel, 32-bit userspace. 
It has a ~86KB chunk of memory near the top of the process address 
space, and I'm not sure who's setting it up and what the purpose is.  In 
/proc/<pid>/maps it looks like this:

fffea000-fffff000 rw-p fffea000 00:00 0

Can anyone enlighten me as to what this is for and who is allocating it?

Thanks,

Chris
