Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1BEB9DDF40
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 00:18:32 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IXduG-0000TM-Ot
	for linuxppc-embedded@ozlabs.org; Tue, 18 Sep 2007 07:18:28 -0700
Message-ID: <12758059.post@talk.nabble.com>
Date: Tue, 18 Sep 2007 07:18:28 -0700 (PDT)
From: Junqiang Hu <jqhu936@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet adapter not found in Xilinx ppc, with linux 2.6.22
In-Reply-To: <BAY138-F271854679106F05A7C7117B2B80@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <12745876.post@talk.nabble.com>
	<BAY138-F271854679106F05A7C7117B2B80@phx.gbl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi, Ming,

   I do have the Xilinx generated Ethernet driver in hand, but could you
suggest how to add that driver into my 2.6.22 version?

Thanks!


mliu wrote:
>=20
> Hi,
>>
>>After several days of struggling I'm now able to boot the linux 2.6.22 an=
d
>>run the busybox-1.7.1 root system.  Yet I could not find the Ethernet
>>adapter using Xilinx GMAC core.  Pretty sure that I've chosen the 10/100
>>Ethernet drivers.  Should I use the Xilinx driver xemac, or other drivers=
,
>>or any other way to apply a patch?
>=20
> If you are using gigabit ethernet, you must have the corresponding driver=
=20
> (gigabit or tri-state) instead of 10/100 one included.=20
>=20
> BR
> Ming
>=20
> _________________________________________________________________
> =E5=85=8D=E8=B4=B9=E4=B8=8B=E8=BD=BD MSN Explorer:   http://explorer.msn.=
com/lccn/ =20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=20
View this message in context: http://www.nabble.com/Ethernet-adapter-not-fo=
und-in-Xilinx-ppc%2C-with-linux-2.6.22-tf4470255.html#a12758059
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
