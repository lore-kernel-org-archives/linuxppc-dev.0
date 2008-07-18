Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id BEE57DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 13:50:56 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so68144yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 20:50:54 -0700 (PDT)
Message-ID: <9e4733910807172026l4876907ey4814ec0964360c6c@mail.gmail.com>
Date: Thu, 17 Jul 2008 23:26:04 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: wsz_422 <wsz_422@126.com>
Subject: Re: hang on "booting the kernel ...."
In-Reply-To: <11945316.455961216349028828.JavaMail.coremail@bj126app95.126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11945316.455961216349028828.JavaMail.coremail@bj126app95.126.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/17/08, wsz_422 <wsz_422@126.com> wrote:
>
>   Hello!
>         When I boot the kerenl which was compiled by myself on the ML403,but
> it hang on "booting the kernel ",the prompt information is as follow:
>     Linux
>     uncompressing the kernel ....done
>     Now booting the kernel
> and then there is nothing .
>     The linux code I used is linux-2.6-xlix,the version is 2.6.22.And I use
> the uartlite IP.And use the XMD to download the kernel,the command is dow
> zImage.elf,con.
>     I don't know what the problem is.Can you give me a help? Thanks you!


Most likely is that the root name in your device tree doesn't match a
name that has been compiled into the kernel.


>
>
>
> _______________________________________________
>  Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Jon Smirl
jonsmirl@gmail.com
