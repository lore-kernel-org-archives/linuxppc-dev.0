To: caixupeng <edmoon@huawei.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot, ebony , change baudrate function has bug. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Nov 2002 09:44:19 +0800."
             <001d01c294ed$569cecc0$92690b0a@DBKQW41X>
Date: Tue, 26 Nov 2002 09:31:59 +0100
Message-Id: <20021126083204.5EFE8C6134@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001d01c294ed$569cecc0$92690b0a@DBKQW41X> you wrote:
>
> when you set a new baudrate,
>
> => setenv  baudrate 38400
> ## Switch baudrate to 38400 bps and press ENTER ...
>
>
> it will hang .

It does not hang. It waits for you to switch the baudrate  and  press
ENTER.

> I find a way  to avoid it.
> first, clear the baudrate with "setenv baudrate=xxxx"----it's wrong ,

This is an ugly hack,and strongly discouraged.

The way the baudrate change is implemented in PPCBoot is  intentional
-  it prevents you to enter a baudrate which you cannot use with your
terminal. If you cannot type the  enter  and  the  "saveenv"  command
necessary to store the new baudrate permanently, you can always reset
the board ans it will come up with the old, working baudrate.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
For every problem there is one solution which is  simple,  neat,  and
wrong.                                                - H. L. Mencken

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
