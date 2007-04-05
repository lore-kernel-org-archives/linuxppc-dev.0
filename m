Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302C194B9@az33exm25.fsl.freescale.net>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<20070329003550.GB25652@localhost.localdomain>
	<20070402181553.GH2132@mag.az.mvista.com>
	<f622cb9af058a72fc47521e44ae6672a@kernel.crashing.org>
	<20070404162905.GD21314@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302C194B9@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3b592979f429a363f3b681eccb271522@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Thu, 5 Apr 2007 19:48:53 +0200
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> the PowerPC binding defines this--
>
>  + 5.1.7. Memory Management Unit properties

<snip>

> The "mode" field seems to be undefined.

It's defined in 6.1 in the same doc -- briefly, it's
a bitfield WIMGxPP.

> So would firmware need to define all phys to virt mappings in
> the "translations" property or just the interesting ones-- i.e
> uart/console and i2c?

In principle, all.  But since you won't invoke any
client interface services ever (you don't _have_ a
real OF after all ;-) ) you might be able to get
away with describing only the ones you are going
to use.


Segher
