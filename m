Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id DE1642BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Nov 2004 02:34:26 +1100 (EST)
To: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Nov 2004 14:13:51 GMT."
	<OF5D3B44B5.3530BFCD-ON00256F43.0035B584-00256F43.004E2C6C@marel.is>
Date: Fri, 05 Nov 2004 15:32:18 +0100
Sender: wd@denx.de
Message-Id: <20041105143223.52CDFC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Handling power failure - MPC5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OF5D3B44B5.3530BFCD-ON00256F43.0035B584-00256F43.004E2C6C@marel.is> you wrote:
>
> > Use the standard methods: use the CF card read-only  (many  CF  cards
> > can  be  damaged  [beyond  repair]  when  you power off while a write
> > operation is in progress).
> 
> Is this an acknowledged fact by CF manufacturers or based on experiece ?

You mean acknowledged officially in writing on letterhead paper?  No.
Inofficially: yes.

Also many people have confirmed this behaviour, at least on the cheap
"standard" (versus "industrial grade") CF cards.

I recommend to specifically ask your CF card vendor / distributor for
a confirmation and guarantee (in writing) that it is safe to turn off
power while writing to the device. Guess what you will get?

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The whole world is about three drinks behind."     - Humphrey Bogart
