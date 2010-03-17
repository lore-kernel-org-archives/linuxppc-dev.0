Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41D35B7D09
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 10:04:38 +1100 (EST)
Subject: Re: Problem with PCI bus rescan on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4BA08B61.5000406@embedded-sol.com>
References: <4B8E6FA3.70503@embedded-sol.com>
	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>
	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com> <4B9DCF01.4050709@embedded-sol.com>
	<4B9DF72F.3040105@jp.fujitsu.com> <4B9E18A7.2080605@embedded-sol.com>
	<4B9F19E2.2090709@jp.fujitsu.com> <4B9FFAD1.8030309@embedded-sol.com>
	<4BA02A49.9050101@jp.fujitsu.com> <4BA086EF.6080708@embedded-sol.com>
	<1268812060.2335.174.camel@pasglop> <4BA08B61.5000406@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 10:04:12 +1100
Message-ID: <1268867052.2335.205.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-pci@vger.kernel.org, yinghai@kernel.org,
	Alex Chiang <achiang@hp.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > This is Jesse tree with the default Canyonlands defconfig ? Hrm... I'll
> > have to take a look, somebody mucking with PCI resource allocation is
> > very likely to break something :-)
> >
> >
> >   
> 
> Yep, default Canyonlands defconfig and default DTS.

Which branch of Jesse tree btw ? "master" ?

Cheers,
Ben.
