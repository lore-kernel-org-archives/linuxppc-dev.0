Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5DE1A0BAF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 05:04:26 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2708514012F
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 05:04:25 +1000 (AEST)
Date: Sun, 12 Apr 2015 14:04:09 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
Message-ID: <20150412190409.GA16978@gate.crashing.org>
References: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
 <20150410142414.0ea55c4b@canb.auug.org.au>
 <1428643714.30592.4.camel@ellerman.id.au>
 <20150410164208.1cc2a994@canb.auug.org.au>
 <1428662335.21137.1.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428662335.21137.1.camel@ellerman.id.au>
Cc: Olof Johannsson <olof@lixom.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 10, 2015 at 08:38:55PM +1000, Michael Ellerman wrote:
> BUT, I can't work out how to tell git-send-email I *always* want to pass -M, so
> I'll probably forget next time :)

In your config:

--
[diff]
	renames = true
--

but this will do it for all diffs, not just for format-patch.


Segher
