Return-Path: <dhlii@picocomputing.net>
Received: from outbound-mail-38.bluehost.com (outbound-mail-38.bluehost.com
	[69.89.20.192]) by ozlabs.org (Postfix) with SMTP id DDBE2DE5EE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 05:50:28 +1000 (EST)
Message-ID: <480F917F.8040809@picocomputing.net>
Date: Wed, 23 Apr 2008 15:43:59 -0400
From: "David H. Lynch Jr." <dhlii@picocomputing.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: simpleboot
References: <480F8148.8090906@picocomputing.net>
	<fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>
In-Reply-To: <fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> make simpleImage.<boardname>
> - or -
> make simpleImage.initrd.<boardname>
>
> The makefile will use arch/powerpc/boot/dts/<boardname>.dts for the device tree.
    Thanks, I suspected most of that. But I have not see simpleboot in
Linus's tree yet,
    so I have to back port the patch from the paulus tree and that makes
it harder to just try it.

    I am correct in assuming that if I have my .config otherwise
properly setup for initramfs that
    it is going to merge the kernel, dts, and initramfs into a single
image ?

    and is initramfs the plain or initrd target the correct one for
initramfs ?


-- 
Dave Lynch                                          Pico Computing, Inc.
Software Development                                      Embedded Linux
717.627.3770      dhlii@picocomputing.net   http://www.picocomputing.com
fax: 1.253.369.9244                                 Cell: 1.717.587.7774
Tiny Mighty Machines
