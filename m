Return-Path: <jk@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BB907B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 19:14:55 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D222DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 19:14:55 +1000 (EST)
From: Jeremy Kerr <jk@ozlabs.org>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] spufs: remove redundant test on unsigned
Date: Tue, 23 Jun 2009 17:12:18 +0800
References: <4A3FF508.3000304@gmail.com> <4A4003AD.20408@gmail.com>
In-Reply-To: <4A4003AD.20408@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906231712.19153.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roel,

> Unsigned `len' cannot be less than 0.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Thanks for the patch. However, we have a patch from Christoph Hellwig 
pending that will rework the sputrace code:

 http://patchwork.ozlabs.org/patch/28641/

It's currently queued in benh's tree, should be up soon.

Cheers,


Jeremy
