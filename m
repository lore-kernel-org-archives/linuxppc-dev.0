Return-Path: <dceravigupta@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 4CE81B70CB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 20:01:13 +1000 (EST)
Received: by pxi17 with SMTP id 17so1225859pxi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Aug 2010 03:01:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100812153618.GA7498@ovro.caltech.edu>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTikNt7hrxA+QR-omUiiLKVBnjqCw+HTDQh_5B5Ff@mail.gmail.com>
	<AANLkTi=-YiWtBqCGSt-h8dd3WwTMVJcDitvROCDBEMdw@mail.gmail.com>
	<20100812153618.GA7498@ovro.caltech.edu>
Date: Fri, 13 Aug 2010 15:31:11 +0530
Message-ID: <AANLkTikqUsrwPFu75QhuEGj63H0_FX3Jx6TVM4PQfKJw@mail.gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: multipart/alternative; boundary=00163646c428044f82048db19025
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163646c428044f82048db19025
Content-Type: text/plain; charset=ISO-8859-1

> Looking at the device tree for this board, it appears U-Boot remaps the
> IMMR registers to 0xe0000000. They are no longer accessible at
> 0xff400000.
>
> I would recommend studying arch/powerpc/boot/dts/mpc8377_rdb.dts in the
> Linux source code. That describes the device layout on your board after
> U-Boot has run.
>
> A wonderful tool for testing devices from userspace is "busybox devmem".
> It allows you to poke any physical address with any value. The output of
> "busybox devmem --help" should get you started. As a quick example,
> "busybox devmem 0xe0000c00 w 0x1" will write the 32-bit value 0x1 to
> address 0xe0000c00.
>
> I would also recommend using the built-in Linux GPIO API. It works, you
> just need to figure out how to use it. It will be much easier to get
> your code upstream if you use the provided APIs.
>
> The Documentation/gpio.txt file should help you in understanding the
> in-kernel Linux GPIO API. I'm afraid I don't have much experience other
> than accessing it via sysfs from userspace.
>
> Ira
>

Hi Ira,

Thanks for another great reply. Now I can also access gpio memory map
registers.

Thanks and Regards,
Ravi Gupta

--00163646c428044f82048db19025
Content-Type: text/html; charset=ISO-8859-1

<br><div class="gmail_quote"><blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Looking at the device tree for this board, it appears U-Boot remaps the<br>

IMMR registers to 0xe0000000. They are no longer accessible at<br>
0xff400000.<br>
<br>
I would recommend studying arch/powerpc/boot/dts/mpc8377_rdb.dts in the<br>
Linux source code. That describes the device layout on your board after<br>
U-Boot has run.<br>
<br>
A wonderful tool for testing devices from userspace is &quot;busybox devmem&quot;.<br>
It allows you to poke any physical address with any value. The output of<br>
&quot;busybox devmem --help&quot; should get you started. As a quick example,<br>
&quot;busybox devmem 0xe0000c00 w 0x1&quot; will write the 32-bit value 0x1 to<br>
address 0xe0000c00.<br>
<br>
I would also recommend using the built-in Linux GPIO API. It works, you<br>
just need to figure out how to use it. It will be much easier to get<br>
your code upstream if you use the provided APIs.<br>
<br>
The Documentation/gpio.txt file should help you in understanding the<br>
in-kernel Linux GPIO API. I&#39;m afraid I don&#39;t have much experience other<br>
than accessing it via sysfs from userspace.<br>
<font color="#888888"><br>
Ira<br>
</font></blockquote></div><br>Hi Ira,<br><br>Thanks for another great reply. Now I can also access gpio memory map registers.<br><br>Thanks and Regards,<br>Ravi Gupta<br>

--00163646c428044f82048db19025--
