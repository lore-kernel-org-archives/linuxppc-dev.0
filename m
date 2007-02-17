Return-Path: <FENKES@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64EF4DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 11:28:04 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1H0RxrH109164
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 00:27:59 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1H0Rx4i1753174
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:27:59 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1H0Rwet016503
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:27:59 +0100
In-Reply-To: <1171569457.20758.76.camel@sinatra.austin.ibm.com>
To: John Rose <johnrose@austin.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Support dynamic addition and	removal
	of adapters
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFF5C27801.F7BCD37B-ON85257285.0001F062-85257285.00028E7E@de.ibm.com>
Date: Fri, 16 Feb 2007 19:27:57 -0500
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Paul Mackerras <pmac@au1.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
	External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Me Notes <johnrose@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rose <johnrose@austin.ibm.com> wrote on 15.02.2007 14:57:37:

> Looks good.  Questions: how can the user space tools verify the success
> of an add or remove?=20

If the probe operation succeeds, the respective device will show up=20
beneath
/sys/bus/ibmebus/devices.
=20
> Also, will /sys/bus/ibmebus exist even if the system booted with no LHEA
> nodes?

Sure.
=20
> Can we also have an attribute "devspec" that communicates the open
> firmware path through sysfs?

This is already taken care of by of=5Fdevice=5Fregister().

Cheers,
  Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer=20
extraordinaire
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Development =

2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239=20

Vorsitzender des Aufsichtsrats: Johann Weihen  --  Gesch=E4ftsf=FChrung:=20
Herbert Kircher
Sitz der Gesellschaft: B=F6blingen  --  Registergericht: Amtsgericht=20
Stuttgart, HRB 243294
