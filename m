To: "Li Xiangrong" <lixiangrong@china.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem about mac address 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Nov 2002 20:25:32 +0800."
             <200211251219.GAA14313@lists.linuxppc.org>
Date: Mon, 25 Nov 2002 17:14:57 +0100
Message-Id: <20021125161502.A9429C58BF@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200211251219.GAA14313@lists.linuxppc.org> you wrote:
>
> i configured.I searched the kernel and have not find the place to set that addr. The kernel gets the mac addr. from and only from the SDRAM(enet.c):

I don't know where you're looking, but I have a line

	iap = bd->bi_enetaddr;

in our FEC code, which reads the MAC address as passed  by  the  boot
loader in the bd_info struncture.

> this happen and may u give me an advice to solve it?

You provide too little information to allow a really helpful  answer.
Which  CPU?  Which board? Which kernel version? Where did you get the
source from? Who ported the source to your board?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The one charm of marriage is that it makes a  life  of  deception  a
neccessity."                                            - Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
