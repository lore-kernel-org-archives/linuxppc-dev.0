To: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bdi200 or powertap.. help me to decide. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 09 Jan 2003 10:06:45 +0530."
             <3E1CFC5D.5030608@tataelxsi.co.in>
Date: Thu, 09 Jan 2003 09:30:32 +0100
Message-Id: <20030109083037.88D89C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E1CFC5D.5030608@tataelxsi.co.in> you wrote:
>
> I have been following the recent ( and ongoing ) discussions on bdi2000.
> I have recommended the company to buy bdi2000. The company is
> considering bdi2000 and powertap. ( AMC Applied Microsystems
> Corporation's PowerTAP™).
> I am going through the data sheet of powertap and doing a comparitative
> study of both products to find out which one is better suited for linux
> kernel debugging. Frankly we don't need any of the jazz that powertap +
> MWX-ICE™ debugger offers .We will be happy to use GNU tools. One good
> feature I see in powertap is to examine the contents of the registers.
> but I am a little pessimistic about the linux kernel debug support on
> powertap.

Ask yourself (and your AMC /  Metrowerks  sales  guy)  the  following
questions:

* Does the PowerTAP documentation / sales guys claim to support Linux
  as target OS? Especially is the MMU support good enough to debug
  for example dynamically loaded kernel modules?

* How many people on this mailing list actually reported that they
  have successfully used a PowerTAP to debug the Linux kernel
  including dynamically loaded device drivers?

* Is there support for Linux as host OS?

* Does the Linux kernel provide special hooks for the PowerTAP
  (equivalent to the CONFIG_BDI_SWITCH configuration option)?

* Which CPUs are supported by the PowerTAP? The BDI2000 supports
  CPU32/32+, ColdFire, PowerPC, ARM, MIPS32, XScale and M-CORE ...


Guess what we're using...


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I wish I had a bronze torc for every user who didn't read the manual.
                             - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
