To: iida <iida@ztec.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: watchdog in lite5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Jun 2004 11:23:45 -0300."
             <40CF0671.4040002@ztec.com.br>
Date: Tue, 15 Jun 2004 20:36:19 +0200
Message-Id: <20040615183624.B0BDAC13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40CF0671.4040002@ztec.com.br> you wrote:
>
> i am tring to use the watchdog in a lite5200
> In menuconfig , i find the watchdog in char devices
> but none of the cotrolers is for internal watchdog of mpc5200
> In 5xxx/IO dont appear to show a driver for internal watchdog either.
>
> So i have to develop the driver for watchdog in mpc5200 ?

No. Check out the recent version from our CVS  tree.  It  contains  a
powerful  watchdog driver. For a documentation of the API, please see
Documentation/man4/wdt_mpc8xx.4

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There are three principal ways to lose money: wine, women,  and  en-
gineers.  While  the first two are more pleasant, the third is by far
the more certain."                      -- Baron Rothschild, ca. 1800

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
