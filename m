Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AA2B0B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 16:24:57 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A331DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 16:24:57 +1000 (EST)
Date: Tue, 15 Sep 2009 16:24:57 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Check for unsupported relocs when using
	CONFIG_RELOCATABLE
Message-ID: <20090915062457.GG10656@bilbo.ozlabs.org>
References: <1252994222.8375.201.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1252994222.8375.201.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2009 at 03:57:02PM +1000, Benjamin Herrenschmidt wrote:
 
> diff --git a/arch/powerpc/relocs_check.pl b/arch/powerpc/relocs_check.pl
> new file mode 100755
> index 0000000..215e966
> --- /dev/null
> +++ b/arch/powerpc/relocs_check.pl
> @@ -0,0 +1,57 @@
> +#!/usr/bin/perl
> +
> +# Copyright © 2009 IBM Corporation
> +
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License
> +# as published by the Free Software Foundation; either version
> +# 2 of the License, or (at your option) any later version.
> +
> +# This script checks the relcoations of a vmlinux for "suspicious"
> +# relocations.
> +
> +use strict;
> +use warnings;
> +
> +if ($#ARGV != 1) {
> +	print "$#ARGV\n";

Ooops that line should have been taken out.  Sorry.

Yours Tony
