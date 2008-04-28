Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 50354DDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:40:18 +1000 (EST)
Date: Mon, 28 Apr 2008 22:40:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] make help: Show defconfig subdirs
Message-ID: <20080428204050.GB18248@uranus.ravnborg.org>
References: <f70d44df351c88b7754e2ca93c6075f9660d3a40.1207512931.git.segher@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f70d44df351c88b7754e2ca93c6075f9660d3a40.1207512931.git.segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 06, 2008 at 10:16:07PM +0200, Segher Boessenkool wrote:
> PowerPC will start moving board defconfigs into subarch-specific
> subdirs soon.  "make help" currently does not look in subdirs to
> find the defconfigs to show.  This is partially a good thing,
> since there are way too many defconfigs for one list.
> 
> This patch makes the main "make help" display something like
> 
>   help-40x         - Show 40x-specific targets
>   help-44x         - Show 44x-specific targets
>   help-boards      - Show all of the above
> 
> and wires up stuff so those new help-* commands actually work.
> 
> Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks, applied.
Fixed it up to show x86 defconfig files too.

	Sam
