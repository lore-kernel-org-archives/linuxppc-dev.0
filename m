Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 205ACB7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 13:29:57 +1100 (EST)
Subject: Re: Can't boot benh/powerpc.git kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
In-Reply-To: <1289520464.4752.12.camel@localhost>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
	<1289520464.4752.12.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Nov 2010 13:29:39 +1100
Message-ID: <1289528979.2147.1407.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-11-11 at 16:07 -0800, Jim Keniston wrote:
> I built from Linus's git tree, and that kernel doesn't boot, either.
> (It doesn't hang, but rather panics during boot.  I can provide a
> console log if you like.)
> 
> v2.6.36 and v2.6.37-rc1 boot fine for me.  I'll post my nvram-related
> patches against v2.6.37-rc1.

Ok, pls send me as much details as you can (git rev etc...), log, and
details about the machine. I'll have a look next week.

Cheers,
Ben
