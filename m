To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: driver support ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Oct 2002 11:15:08 CDT."
             <0B0A39652BB0D411BCCF00508B9512EC08AEB515@tx14exm05.ftw.mot.com>
Date: Fri, 18 Oct 2002 18:28:09 +0200
Message-Id: <20021018162814.5AE3B10143@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0B0A39652BB0D411BCCF00508B9512EC08AEB515@tx14exm05.ftw.mot.com> you wrote:
>
> I wish to port the linux to another custom board with 7410 + mpc107 with
> TI's 752 uart chip and national semi's dp83815 integrated mac and phy.
>
> 1. Does anyone know if these uart driver and ethernet driver exist in
> current
> release of Monta Vista preview 2.1 or ELDK ?

Please note that the ELDK is primarily an Embedded Linux  Development
Kit; it ships with a 2.4.4 kernel, which is very reliable and running
really  well, but for new projects you should probalby base your work
on the linuxppc_2_4_devel kernel instead.

Neither the 752 nor the DP83815 will run out  of  the  box  with  our
2.4.4 kernel.

> 2. Where should I look at if I have to modify the uart driver ? I guess this
> uart
> should be easily ported.

Umm... I don't understand the  question?  You  should  look  at  your
driver's source code, of course ;-)

> Right now after I downloaded the built linux image, I could not see anything
> on serial port.

Attach your BDI2000, and start GDB.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only way to get rid of a temptation is to yield to it.
                                                        - Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
