To: "He Xudong" <xdhe@utstar.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uart problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 17 Sep 2003 09:47:37 +0800."
             <9733CD15FD6A2C418132CE83BCDB16F60155CE25@hzmail1.cn.utstar.com>
Date: Thu, 18 Sep 2003 15:26:39 +0200
Message-Id: <20030918132644.19055C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <9733CD15FD6A2C418132CE83BCDB16F60155CE25@hzmail1.cn.utstar.com> you wrote:
>
> 	I'm using the eldk linux-2.4.4 kernel.
> 	I use the 2 SMC and 3 SCC (SCC2,SCC3,SCC4) in 8260_io/uart.c.
> change the rs_table,io configuration,and the brg.
...
> I have use the oscillograph to see if the signal have reach the 8260,
> it is.and so does my SMC2.(the SCC4 even have no interrupt).whould you
> please give me some advice about it,thx a lot.

Please check out our 2.4.20 kernel (module linuxppc_2_4_devel on  our
CVS server). We fixed a couple of issues recently.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No more blah, blah, blah!
	-- Kirk, "Miri", stardate 2713.6

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
