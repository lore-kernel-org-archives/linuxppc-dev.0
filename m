Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 56DF667A33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 05:16:40 +1100 (EST)
To: iseno@tomen-ele.co.jp
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Where to define IO ports 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Mar 2006 15:01:37 +0900."
	<D7E527950707D611B2A20003474C612A0BD92821@tmemail0.tomen-ele.co.jp>
Date: Tue, 14 Mar 2006 19:16:38 +0100
Sender: wd@denx.de
Message-Id: <20060314181638.3586D3539FF@atlas.denx.de>
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

In message <D7E527950707D611B2A20003474C612A0BD92821@tmemail0.tomen-ele.co.jp> you wrote:
> 
> I think you should change the "u-boot".

NO. Linux stuff should be donme in Linux.

>  - include/configs/IceCube.h
>  - board/icecube/icecube.h
> 
> 1st, put a constant like (CFG_CS1_START, CFG_CS1_STOP, CFG_CS1_CFG) to
> IceCube.h.

NO again. If you port to your own board, you should create  your  own
board  configuration  instead  of  messing  with  an existing one for
another board.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Brontosaurus Principle: Organizations  can  grow  faster  than  their
brains  can manage them in relation to their environment and to their
own physiology: when this occurs, they are an endangered species.
                                                - Thomas K. Connellan
