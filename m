Message-Id: <200008281426.QAA29658@denx.local.net>
To: Christopher Huffine <huffine@wopr.nrl.navy.mil>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 823 ports access question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 28 Aug 2000 07:18:55 EDT."
             <Pine.LNX.3.96.1000828071718.5707A-100000@wopr.nrl.navy.mil>
Date: Mon, 28 Aug 2000 16:26:04 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.3.96.1000828071718.5707A-100000@wopr.nrl.navy.mil> you wrote:
>
> Sorry to write another simplistic question; hopefully
> there is a simplistic answer as well:

There is :-)

> PPC ports.  For example, the Bright Star
> ipEngine I have has LEDs connected to the LCD ports
> from the PowerPC.  I'm looking for the right
> sequence to actually write to these ports and
> get these LEDs to turn on and off.
>
> I've looked in 8xx_immap.h and I start to see
> what I need to make this work (im_lcd), but I'm missing
> the bigger picture.  Anyone have any example
> code for anything like this?

See the tqm_led demo driver code under
http://www.denx.de/solutions-en.html#drivers

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Do we define evil as the absence of goodness? It seems only  logical
that shit happens--we discover this by the process of elimination."
                                                        -- Larry Wall

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
