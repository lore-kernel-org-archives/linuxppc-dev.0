Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id E785767D53
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 04:58:59 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1050957ugc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 09:58:58 -0800 (PST)
Message-ID: <528646bc0610300958p627a79abyd84059854a8ca47@mail.gmail.com>
Date: Mon, 30 Oct 2006 10:58:52 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: Xubuntu and Xenomai on the Lite5200 (IceCube)...
In-Reply-To: <200610301209.38103.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200610301209.38103.david.jander@protonic.nl>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/30/06, David Jander <david.jander@protonic.nl> wrote:
>
> Hi all,
>
> I got the task to help make Linux run on the IceCube, with support for MSCAN,
> FEC and USB. After a rather exciting jurney I managed to get kernel 2.6.18
> working with bestcomm DMA and FEC support backported from DENX's git
> 2.6.19-rcsomething, and Xenomai installed upon that.
> Btw, before Wolfgang Denk starts complaining why I didn't use his 2.4 kernel,
> it's because I wasn't smart enough to get USB working. If it does work,
> please tell me how, I just get errors when plugging in a USB device "kernel:
> usb.c: USB device not accepting new address=2 (error=-110)".
> This seems to work fine in 2.6, though.
> It was not easy, so I wrote everything down (I hope I didn't forget anything
> important):
>
> http://yopesblog.blogspot.com/2006/10/how-to-run-ubuntu-and-xenomai-on.html

Congratulations, that's good work!  Especially the bit about
documenting what you did!  I've been meaning to play w/ xenomai for a
while now.

Care to help with the port to arch/powerpc now?  :P

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
