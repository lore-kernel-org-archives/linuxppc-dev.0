Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6jn93WgxzDvML
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 16:37:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix error handling
In-Reply-To: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
Date: Mon, 31 Oct 2016 16:37:49 +1100
Message-ID: <87wpgp13ki.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> 'cxl_dev_context_init()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> un-compiled because I don't have the required  cross build environment.

Do you run Ubuntu or Fedora? If so it's just a dnf/apt-get away:

$ sudo dnf install gcc-c++-powerpc64-linux-gnu binutils-powerpc64-linux-gnu gcc-powerpc64-linux-gnu
or
$ sudo apt-get install gcc-powerpc64le-linux-gnu gcc-powerpc-linux-gnu libc-dev-powerpc-cross libc-dev-ppc64el-cross

More here:

https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels


cheers
