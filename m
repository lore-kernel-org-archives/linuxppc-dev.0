Return-Path: <FENKES@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1B4EDDDF9
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 02:53:22 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1HFrHit184836
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 15:53:17 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1HFrH9W1818676
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 16:53:17 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1HFrGMh016482
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 16:53:17 +0100
In-Reply-To: <45D6CC81.1040004@246tNt.com>
To: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Use of_device_uevent()
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFA3D529A5.FA8E67C7-ON85257285.00570531-85257285.0057458C@de.ibm.com>
Date: Sat, 17 Feb 2007 10:53:15 -0500
Content-Type: text/plain; charset="ISO-8859-1"
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut <tnt@246tNt.com> wrote on 17.02.2007 04:36:01:

> Doesn't that oops when called with the fake parent device ?

I should stop posting patches after 12 hours of work ,)

> Or, an even better approach is to add this
>=20
> +   if (!ebus=5Fdev->ofdev.node)
> +      return -ENODEV;
>=20
> inside the code of of=5Fdevice=5Fuevent itself.

Nice! Patch will follow.

Thanks again,
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
