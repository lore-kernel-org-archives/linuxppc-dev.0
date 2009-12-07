Return-Path: <scottwood@freescale.com>
Date: Mon, 7 Dec 2009 12:07:19 -0600
From: Scott Wood <scottwood@freescale.com>
To: ajijuni@gmail.com
Subject: Re: dts file for MPC8343EA
Message-ID: <20091207180719.GB8914@loki.buserror.net>
References: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 06, 2009 at 10:41:25PM -0800, ajijuni@gmail.com wrote:
> Hi 
> 
> We have an MPC8343EA based custom board. 
> 
> I am not able to get Linux up and running in this. No serial output to debug further. 
>  U-boot shows correct 'bdinfo' & 'clocks' output. 
> inux hangs at machine_probe.

Check that the platform file you're intending to use matches the compatible
field in the root node of the device tree -- and that said platform file is
actually being built.

-Scott
