Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5436A67C5C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 04:31:29 +1000 (EST)
Message-ID: <4512D3F4.60405@am.sony.com>
Date: Thu, 21 Sep 2006 11:03:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Create a "wrapper" script and use it in
	arch/powerpc/boot
References: <17682.28743.743974.786724@cargo.ozlabs.ibm.com>
In-Reply-To: <17682.28743.743974.786724@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Another point to note is that this renames the images: the one for
> pSeries is called zImage.pseries rather than zImage, and the one for
> powermacs is now zImage.pmac rather than zImage.vmode.


zImage.vmode was my name, and I never liked it...


> +if [ -n "$dts" ]; then
> +    if [ -z "$dtb" ]; then
> +	dtb="$platform.dtb"
> +    fi
> +    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1

I'm wondering if this would be better to have built by the
upper level makefile and have quiet_cmd_dtc and cmd_dtc.
Its just a thought.  Did you consider it?

-Geoff
