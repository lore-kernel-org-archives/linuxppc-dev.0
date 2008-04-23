Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 1C66EDDFF6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 05:48:48 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so736209anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 12:48:47 -0700 (PDT)
Message-ID: <fa686aa40804231248s162479d9o530051d3c88da471@mail.gmail.com>
Date: Wed, 23 Apr 2008 13:48:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@picocomputing.net>
Subject: Re: simpleboot
In-Reply-To: <480F917F.8040809@picocomputing.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <480F8148.8090906@picocomputing.net>
	<fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>
	<480F917F.8040809@picocomputing.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2008 at 1:43 PM, David H. Lynch Jr.
<dhlii@picocomputing.net> wrote:
> Grant Likely wrote:
>  > make simpleImage.<boardname>
>  > - or -
>  > make simpleImage.initrd.<boardname>
>  >
>  > The makefile will use arch/powerpc/boot/dts/<boardname>.dts for the device tree.
>     Thanks, I suspected most of that. But I have not see simpleboot in
>  Linus's tree yet,
>     so I have to back port the patch from the paulus tree and that makes
>  it harder to just try it.
>
>     I am correct in assuming that if I have my .config otherwise
>  properly setup for initramfs that
>     it is going to merge the kernel, dts, and initramfs into a single
>  image ?

Yes, the dtb and ramdisk images are just put into the wrapper image.
There are no .config values that manipulate the wrapping operation.
>
>     and is initramfs the plain or initrd target the correct one for
> initramfs ?

Its whatever kind of image you pass it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
