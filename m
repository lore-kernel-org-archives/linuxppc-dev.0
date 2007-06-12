Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBACDDDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 15:03:57 +1000 (EST)
Subject: Re: [patch 00/18] PS3 patches for 2.6.23
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <71e5ae7f85657e4ab5bfbc809cab9c60@bga.com>
References: <71e5ae7f85657e4ab5bfbc809cab9c60@bga.com>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 15:03:37 +1000
Message-Id: <1181624617.14818.248.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-11 at 02:08 -0500, Milton Miller wrote:

> (Or disable the ps3 system bus during the merge of the series).

Considering that

 - It breaks only ps3
 - ps3, as of today, doesn't quite work anyway without those patches

I'd be tempted to say bisect doesn't matter. If you're bisecting
something else, then just disable ps3 support.

Ben.
