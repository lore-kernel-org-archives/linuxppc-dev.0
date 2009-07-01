Return-Path: <jan.neskudla.ext@nsn.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2D139B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 00:50:04 +1000 (EST)
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
	[217.115.75.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "demumfd001.nsn-inter.net",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D68FDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 00:50:01 +1000 (EST)
Subject: Re: RapidIO - general questions
From: Jan Neskudla <jan.neskudla.ext@nsn.com>
To: "ext david.hagood@gmail.com" <david.hagood@gmail.com>
In-Reply-To: <bd421daddbfcd48f86096879ce621310.squirrel@localhost>
References: <1242119872.16400.113.camel@demuxf9c>
	<2a27d3730905130357re0adf41l19f5603a70dac57b@mail.gmail.com>
	<1242372791.26759.34.camel@demuxf9c>
	<2a27d3730905150056m7298b66ckb9db92f9432953d6@mail.gmail.com>
	<1242802800.9160.143.camel@demuxf9c>
	<1246285193.10035.245.camel@demux9hc>
	<bd421daddbfcd48f86096879ce621310.squirrel@localhost>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 16:46:18 +0200
Message-Id: <1246459578.10035.292.camel@demux9hc>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ext Li Yang <leoli@freescale.com>,
	linux-kernel@vger.kernel.org, "IDT - Kim, Chul" <Chul.Kim@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-29 at 10:44 -0500, ext david.hagood@gmail.com wrote:
> Do you know (and if you know, can you comment) if IDT is planning on
> offering RIO (and more importantly to me sRIO) chipsets that can be used
> on other architectures besides the various PPC chips with embedded sRIO
> controllers?
I am using only switches, and they are not fixed to any architecture.
You can use them independently to any MCU. 
I do not know if they are planning to provides something more. 
                     Jan 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
