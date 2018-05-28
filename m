Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vfbh1nY4zDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 00:38:05 +1000 (AEST)
Date: Mon, 28 May 2018 09:37:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/Makefile: fix build failure by disabling
 attribute-alias warning
Message-ID: <20180528143719.GB17342@gate.crashing.org>
References: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0adce33cf1c70ac7203f8ebd987a912451aabd45.1527517001.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 28, 2018 at 02:17:49PM +0000, Christophe Leroy wrote:
> Latest GCC version emit many warnings similar to the following one.

You didn't actually show an example?

This warning should detect serious problems, so don't disable it without
first investigating please.

What do you call "latest version", btw?  Trunk, aka 9.0?  Or the most
advanced release, 8.1?  Or the latest release (which also is 8.1 :-) )


Segher
