Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70D7267B55
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 20:34:12 +1000 (EST)
Subject: Re: Linux v2.6.18-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <pan.2006.07.07.15.41.35.528827@us.ibm.com>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 20:34:02 +1000
Message-Id: <1152441242.4128.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> We've got a ppc64 machine that won't boot with this due to an IDE error.

What machine precisely ?

> [snip]
> Freeing unused kernel memory: 256k freed
>  running (1:2) /init autobench_args: ABAT:1152213829
> 
> creating device nodes .hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> 
