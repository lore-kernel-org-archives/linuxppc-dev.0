Return-Path: <dhbaird@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id CD234DDF99
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 01:51:41 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so147432yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 08:51:40 -0700 (PDT)
Message-ID: <440abda90807180851n55cc1a81v9fbbcd6c0f6b7fe7@mail.gmail.com>
Date: Fri, 18 Jul 2008 09:51:39 -0600
From: "David Baird" <dhbaird@gmail.com>
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

On Thu, Jul 17, 2008 at 8:43 PM, wsz_422 <wsz_422@126.com> wrote:
>
>   Hello!
>         When I boot the kerenl which was compiled by myself on the ML403,but
> it hang on "booting the kernel ",the prompt information is as follow:
>     Linux
>     uncompressing the kernel ....done
>     Now booting the kernel
> and then there is nothing .

This problem comes up a lot.  Try searching the archives for ML403 and
__log_buf.
