Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.237])
	by ozlabs.org (Postfix) with ESMTP id DFF7FDDF01
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 15:17:24 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id z8so64906qbc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 22:17:22 -0700 (PDT)
Message-ID: <fa686aa40706262217td510097u23d6667a71c1a65a@mail.gmail.com>
Date: Wed, 27 Jun 2007 01:17:22 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: sarpa <vsarpangala@satline.net>
Subject: Re: zImage on mpc5200
In-Reply-To: <11307459.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11307459.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/26/07, sarpa <vsarpangala@satline.net> wrote:
>
> I am building the Linux kernel target "zImage.elf" in PPC branch of Linux
> Kernel 2.6.16.11 and then converting it to zImage.bin using OBJCOPY so that
> i can flash it to my PPC based target using BDI. i am currently facing
> issues in booting this kernel using my own bootloader(i am not using
> u-boot). Before I flood mailing list with more detailed questions I just
> wish to know if the standalone kernel image type zImage.elf is know to work
> in Linux kernel 2.6.16.11 or not ? Has anyone ever tested standalone
> zImage.elf on PPC ? Note that I am able to boot uImage using U-boot for this
> kernel but now I am trying to use my own Bootloader to boot zImage.elf "

I can't say about it on the 5200, or on kernel 2.6.16 because I
haven't tried that exact configuration (without u-boot); but
zImage.elf do boot perfectly well without u-boot.  I frequently boot
my virtex platform in that way.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
