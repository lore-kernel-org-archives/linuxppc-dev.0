Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 45C6AB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 09:36:58 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 547A5DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 09:36:57 +1000 (EST)
Date: Thu, 6 Aug 2009 19:30:02 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
Subject: Re: [PATCH][powerpc/85xx] P2020RDB Platform Support Added
Message-ID: <20090806193002.18c096af@lappy.seanm.ca>
In-Reply-To: <1BD5CFC378ED0946B688E0C9BA2EF0951931A6@zin33exm24.fsl.freescale.net>
References: <1249532639-20070-1-git-send-email-poonam.aggrwal@freescale.com>
	<4A7A776D.7080400@embedded-sol.com>
	<1BD5CFC378ED0946B688E0C9BA2EF09519312F@zin33exm24.fsl.freescale.net>
	<4A7A7C45.4040800@embedded-sol.com>
	<1BD5CFC378ED0946B688E0C9BA2EF0951931A6@zin33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>,
	linuxppc-release@webnode01-prod1.am.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Aug 2009 17:04:18 +0530
"Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com> wrote:

> Can u point me to some reference of this, shud they be partition@0,
> partition@1, etc...
> I am not able to configure all the partitions successfully.

Not unless all your partitions are 1 byte long ;)

The number is the offset into the device. Here is an example partition
table from the warp:

partition@0 {
	label = "kernel";
	reg = <0x00000000 0x00200000>;
};
partition@200000 {
	label = "root";
	reg = <0x00200000 0x03E00000>;
};
partition@40000000 {
	label = "persistent";
	reg = <0x04000000 0x04000000>;
};

Cheers,
   Sean
