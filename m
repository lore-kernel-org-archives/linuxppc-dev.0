Return-Path: <mgreer@mvista.com>
Date: Tue, 10 Apr 2007 17:26:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: Add Makefile rule to wrap dts file in zImage
Message-ID: <20070411002647.GA3624@mag.az.mvista.com>
References: <20070411002534.GA3361@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070411002534.GA3361@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2007 at 05:25:34PM -0700, Mark A. Greer wrote:
> Add 'zImage.dts' and 'zImage.dts_initrd' build rules that automatically
> compile and wrap a dts file from arch/powerpc/boot/dts into the zImage file.
> The rules are similar to the initrd rules.
> 
> The dts file is expected to be arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Argh, ignore this.  I'll make one that applies in a bit.

Mark
