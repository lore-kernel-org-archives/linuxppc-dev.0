To: Arun Dharankar <ADharankar@attbi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: I2C driver for MPC8260. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 12 Apr 2003 20:43:07 EDT."
             <200304122043.07572.ADharankar@ATTBI.Com>
Date: Sun, 13 Apr 2003 11:26:29 +0200
Message-Id: <20030413092634.D74D1C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200304122043.07572.ADharankar@ATTBI.Com> you wrote:
>
> I could find the MPC860 algo driver for I2C, but dont
> know how well it adapts to MPC8260. Can anyone provide
> any pointers? Also, any test app to work with it?

We use the i2c-algo-8260  driver  on  a  couple  of  8250/8260  based
boards;  see  for example the configurations for the CPU86, PM825 and
PM826 boards in our  source  tree  (see  the  files  i2c-cpu86.c  and
i2c-pm826.c in drivers/i2c)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There is no distinctly American criminal class except Congress."
- Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
