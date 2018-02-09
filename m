Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdJS36hyQzF0m4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 02:11:31 +1100 (AEDT)
Date: Fri, 9 Feb 2018 09:11:16 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Albert Herranz <albert_herranz@yahoo.es>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180209151116.GQ21977@gate.crashing.org>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net>
 <20180209120732.17863-3-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2018 at 01:07:29PM +0100, Jonathan Neuschäfer wrote:
> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
> 
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
> 
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Looks just fine to me :-)


Segher
