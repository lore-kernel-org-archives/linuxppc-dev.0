Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2E43B7D5F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 14:23:24 +1000 (EST)
Subject: Re: powermac/low_i2c.c: three minor problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: d binderman <dcb314@hotmail.com>
In-Reply-To: <BLU108-W1270106CF117770B0ABB269C530@phx.gbl>
References: <BLU108-W1270106CF117770B0ABB269C530@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 14:23:17 +1000
Message-ID: <1270614197.13812.123.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-02-06 at 12:13 +0000, d binderman wrote:
> 
> Hello there,
> 
> I just ran the sourceforge tool cppcheck over the source code of the
> new Linux kernel 2.6.33-rc6

Hi !

All your patches have various problems with the actual patch format.

Patches should be submitted so that they apply with patch -p1, yours
don't. In fact, the base directory you diffed from seems to differ from
patch to patch. I'm manually fixing those this time around, but please
get that sorted out before you submit a new batch.

Cheers,
Ben.

> It said
> 
> [./arch/powerpc/platforms/powermac/low_i2c.c:594]: (style) The scope of the variable chans can be reduced
> [./arch/powerpc/platforms/powermac/low_i2c.c:594]: (style) The scope of the variable i can be reduced
> [./arch/powerpc/platforms/powermac/low_i2c.c:1260]: (style) Redundant condition. It is safe to deallocate a NULL pointer
> 
> Please find attached a patch to fix these minor problems.  
> The patched version compiles, but I have not been able to test it at run time.
> 
> Regards
> 
> David Binderman
>  		 	   		  
> _________________________________________________________________
> Do you have a story that started on Hotmail? Tell us now
> http://clk.atdmt.com/UKM/go/195013117/direct/01/
