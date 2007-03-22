Return-Path: <fenkes@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32786DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 04:19:01 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2MHIvHp019668
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 17:18:57 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2MHIuFE2240648
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 18:18:56 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2MHItIM031342
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 18:18:56 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ibmebus: change probe/remove interface from using
	loc-code to DT path
Date: Thu, 22 Mar 2007 18:15:50 +0100
References: <200703221700.46292.fenkes@de.ibm.com>
In-Reply-To: <200703221700.46292.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703221815.50506.fenkes@de.ibm.com>
Cc: pmac@au1.ibm.com, themann@de.ibm.com, linux-kernel@vger.kernel.org,
	paulus@samba.org, johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 22 March 2007 17:00, Joachim Fenkes wrote:
> Example:
> 
>  Add a device "/proc/device-tree/foo@12345678" to ibmebus like this:
>     echo /foo@12345678 > /sys/bus/ibmebus/probe
> 
>  Remove the device like this:
>     echo /foo@12345678 > /sys/bus/ibmebus/remove
> 

Of course, we have tested this on our own machines, including error
paths, and it worked fine.

Cheers,
  Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239
