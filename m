Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 213CC67B1B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 08:22:45 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 85xx FDT updates? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 16:38:06 CDT."
	<D6F58AA4-54EA-44BF-A0B7-83397B115B27@kernel.crashing.org>
Date: Wed, 26 Apr 2006 00:22:42 +0200
Sender: wd@denx.de
Message-Id: <20060425222242.F2A77353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <D6F58AA4-54EA-44BF-A0B7-83397B115B27@kernel.crashing.org> you wrote:
> 
> > Some do. Some use them in products.
> 
> Can you give a concrete example of this.

No, I cannot. Not in public.

> > Others (and not a small number)  use  them  for  testing  application
> > code. In your definition these are probably "end users", too.
> 
> Then they can use the kernel the board comes with.

No, they cannot. Running different  kernel  versions  (including  old
ones,  eventually even 2.4) may be the key issue of their tests. Note
that this is something which does not require any modification to the
board - I can just TFTP the kernel image and boot it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Weekends were made for programming.                 - Karl Lehenbauer
