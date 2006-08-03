Return-Path: <wd@denx.de>
To: "Li Yang" <LeoLi@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2006 23:56:52 +0800."
	<a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
Date: Thu, 03 Aug 2006 22:02:52 +0200
Sender: wd@denx.de
Message-Id: <20060803200252.96B96352660@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com> you wrote:
>
> If U-boot supports uncompressed kernel image in uImage, I think it
> will be better to use this scheme:
> 
> u-boot header + wrapper + FDT + compressed kernel image

No, this must not be made the only way to build images. It must  also
possible to use uncompressed kernel images.

> As kernel image will be uncompressed to its loading address directly.

Only if it was compressed. This is NOT mandatory.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You don't have to worry about me. I might have been born yesterday...
but I stayed up all night.
