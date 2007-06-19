Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18039.31575.330603.260727@cargo.ozlabs.ibm.com>
Date: Tue, 19 Jun 2007 16:44:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 30/33] PS3: Bootwrapper support.
In-Reply-To: <46771CE7.8040901@am.sony.com>
References: <46730D8A.9090309@am.sony.com>
	<951969d2021fe6e78917ef8bdb47cf6f@bga.com>
	<20070618225537.GA19966@mag.az.mvista.com>
	<46771CE7.8040901@am.sony.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> This is from the comment the patch adds to the wrapper script.  I think
> it gives you what you need:
> 
> +ps3)
> +    # The ps3's loader supports loading gzipped binary images from flash
> +    # rom to addr zero. The loader enters the image at addr 0x100.  A
> +    # bootwrapper overlay is use to arrange for the kernel to be loaded
> +    # to addr zero and to have a suitable bootwrapper entry at 0x100.
> +    # To construct the rom image, 0x100 bytes from offset 0x100 in the
> +    # kernel is copied to the bootwrapper symbol __system_reset_kernel.
> +    # The 0x100 bytes at the bootwrapper symbol __system_reset_overlay is
> +    # then copied to offset 0x100.  At runtime the bootwrapper program
> +    # copies the 0x100 bytes at __system_reset_kernel to addr 0x100.

Yes, that is useful, but Mark is right, your patch description is a
bit terse, and something like that in the patch description would be
useful.

Paul.
