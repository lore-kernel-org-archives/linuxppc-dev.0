To: "okisoftxman" <okisoftxman@hotmail.com>
Cc: "linux-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: about flash_port_width 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Feb 2003 16:52:55 +0900."
             <OE14y3UiIMbhiv9sFU300001b52@hotmail.com>
Date: Fri, 28 Feb 2003 22:31:59 +0100
Message-Id: <20030228213204.7B7E0C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OE14y3UiIMbhiv9sFU300001b52@hotmail.com> you wrote:
>
>     I read the flash manual about INTEL 28F640J3A.I know it has two
> programming operations:Byte or Word.Byte is 8 bits and the Word is 16 bits.
>     but I refer some source code in PPCBOOT(/board/nx823/flash.c),I find a
> strange thing:

Please do NOT post PPCBoot related  questions  to  a  Linux  oriented
mailing list. This is off topic here.

Also note that PPCBoot  is  a  dead  end,  as  development  has  been
discuntinued.  You  should  base  any  current work on the successor,
U-Boot, only.

>     Here,"data" is ulong and "*addr" is vu_long ,they are both 32 bits.Does
> this mean programming operation is 32 bits?If so,it is opposition to the
> FLASH manual.Why?

This is just a configuration that uses two flash chips (one  for  the
lower 16 bits, the other for the upper 16 bits) to give a 32 bit wide
bus.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anarchy may not be the best form of government, but it's better  than
no government at all.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
