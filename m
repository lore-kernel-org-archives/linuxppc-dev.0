Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 0C8EEDDE22
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 20:20:36 +1000 (EST)
Date: Sun, 20 May 2007 12:21:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.22-rc1-mm1
Message-ID: <20070520102132.GB22091@uranus.ravnborg.org>
References: <20070515201914.16944e04.akpm@linux-foundation.org>
	<200705201212.50810.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705201212.50810.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 20, 2007 at 12:12:50PM +0200, Mariusz Kozlowski wrote:
> Hello,
> 
> 	I tried it on iMac G3. I got a bunch of warnings
> and finally it failed to build.
> 
> WARNING: "fee_restarts" [arch/powerpc/kernel/built-in] is COMMON symbol
> WARNING: "ee_restarts" [arch/powerpc/kernel/built-in] is COMMON symbol
> WARNING: arch/powerpc/kernel/built-in.o - Section mismatch: reference to .init.data:.got2 from dt_string_start (offset 0x8)
....

Most - but not all of these warnings should be gone when
Linus pulls kbuild-fix.git.
When -rc3 is ready can you then please post the result of a build.
Then I can take a look at the remaining section mismatch warnings.

	Sam
