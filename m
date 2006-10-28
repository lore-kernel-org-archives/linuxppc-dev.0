Return-Path: <nd@bplan-gmbh.de>
Received: from natcgimail.rzone.de (natcgimail.rzone.de [81.169.145.167])
	by ozlabs.org (Postfix) with ESMTP id CABE667CE1
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 23:42:16 +1000 (EST)
Date: Sat, 28 Oct 2006 15:41:54 +0200 (MEST)
Message-Id: <200610281341.k9SDfsqF020068@post.webmailer.de>
To: "Benjamin Herrenschmidt"<benh@kernel.crashing.org>,
	"Nicolas DET"<nd@bplan-gmbh.de>, "Matt Sealey"<matt@genesi-usa.com>
From: "Nicolas DET"<nd@bplan-gmbh.de>
Subject: Re: EFIKA vs. CHRP platform
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

----- original message --------

Subject: EFIKA vs. CHRP platform
Sent: Sat, 28 Oct 2006
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>


>=20
>  - I'm not sure using RTAS for PCI config space is a very good idea.
> We'll need native mpc52xx_pci.c anyway, so we can juse use it for Efika
> as well instead of taking the massive overhead of RTAS calls on PCI
> config space accesses.
>=20

Compiling...
Efika will use as far as possible RTAS.

Bye
