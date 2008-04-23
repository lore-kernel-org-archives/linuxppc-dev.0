Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 30D9ADE006
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 04:49:05 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2357482wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 11:49:02 -0700 (PDT)
Message-ID: <fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>
Date: Wed, 23 Apr 2008 12:49:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David H. Lynch Jr." <dhlii@picocomputing.net>
Subject: Re: simpleboot
In-Reply-To: <480F8148.8090906@picocomputing.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <480F8148.8090906@picocomputing.net>
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

On Wed, Apr 23, 2008 at 12:34 PM, David H. Lynch Jr.
<dhlii@picocomputing.net> wrote:
>     I am trying to decipher hot to use the simpleboot devicetree wrapper
>  and I am not grasping the process.
>
>     I need an initramfs kernel, inside an elf wrapper.
>     right now I get that pretty much for free.
>
>     How do  ask for a simpleboot wrapper kernel ?
>        It is a target for a makefile in arch/powerpc/boot how to I cause
>  that target to get invoked
>
>     How does it choose the device tree to wrap ?
>
>     How does it interact with things like initramfs ?

make simpleImage.<boardname>
- or -
make simpleImage.initrd.<boardname>

The makefile will use arch/powerpc/boot/dts/<boardname>.dts for the device tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
