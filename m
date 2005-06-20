Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id E6E1D67B21
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Jun 2005 05:25:53 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 20 Jun 2005 12:38:18 +0200."
	<200506201238.19121.david.jander@protonic.nl>
Date: Mon, 20 Jun 2005 21:25:39 +0200
Sender: wd@denx.de
Message-Id: <20050620192544.97393C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: problems on isp1362 driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200506201238.19121.david.jander@protonic.nl> you wrote:
>
> IANAL, but I think theoretically at least, it should be possible, if you 
> manage to craft sort of a "GPL abstraction layer" around the philips driver, 

No, you cannot even do that. The Philips license explicitely  forbids
to  "combine Open Source Software with the Software or any derivative
work thereof". This effectively prevents any use of the driver  in  a
Linux  environment. Of course you can now ask which sense it makes to
release a Linux driver under such a license, but please don't ask me.
Ask the id^H^Hlawyers at Philips.

> do. To the letter of the GPL that is not possible, but AFAIK the linux kernel 
> license grants an exception that permits binary-only drivers for instance.

Please read again. This is allowed only for  pre-existing  code  that
was not written for Linux. And even then it's not really clean. BUt I
seriously doubt that the Philips Linux driver can claim to fall under
this exception.

My interpretation is that an anal-restrictive lawyer came up  with  a
license  once,  and  some  other people applied this license to Linux
drivers without any thinking. If you want to  complain,  complain  at
Philips.  Alternatively,  just  don't  use  their code. If necessary,
don't use their hardware  either.  There  are  other  solutions  with
better software support.

> for me, I decided it is much safer to stay as far away as possible from the 
> philips source. Looking at it could be fatal for an OSS-coder like me (my 
> eyes could get poisoned).
> Here goes a big "BOOOO" to Philips for doing this in the first place :-(

100% ACK from me.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
All your people must learn before you can reach for the stars.
	-- Kirk, "The Gamesters of Triskelion", stardate 3259.2
