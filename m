To: iweiny@pacbell.net
Cc: linuxppc-embedded@lists.linuxppc.org (linuxemb)
Subject: Re: Kernel driver debugging 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Apr 2001 16:52:18 PDT."
             <200104262352.QAA01767@batcave2.batcave>
Date: Fri, 27 Apr 2001 02:13:45 +0200
Message-Id: <20010427001350.760232792B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200104262352.QAA01767@batcave2.batcave> you wrote:
>
> I am looking for the best way to debug kernel modules/drivers.

Get a decent debugger :-)

> In addition we would like to have a way to read registers and other values from
> the hardware as we go forward.

That's one of the basic factions of any BDM/JTAG debugger...

> What is the best solution?

Get yourself a BDI2000.

> I have also read about BDM4GDB and BDI2000.  Is BDI2000 worth the cost?  Are
> there other BDM's for the 405 which work well with Linux?

The BDM4GDB is working only  with  MPC8xx  CPU's  (at  least  in  the
current version). I don't know of any effort to adapt it for the 40x.

And yes, the BDI2000 is worth every single dollar you pay for it.

Feel free to contact me for details...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Defaults are wonderful, just like fire.
                  - Larry Wall in <1996Mar6.004121.27890@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
