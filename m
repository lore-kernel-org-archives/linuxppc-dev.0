To: "xisto.garcia" <xisto.garcia@bol.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [OT] bdiGDB connection problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Mar 2003 17:32:41 -0300."
             <HCFD2H$Ir2UEt49Zg3kPckloUwpF3NOg_PNxkgldEQziM49VK@bol.com.br>
Date: Fri, 28 Mar 2003 01:45:09 +0100
Message-Id: <20030328004514.D8D0FC58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <HCFD2H$Ir2UEt49Zg3kPckloUwpF3NOg_PNxkgldEQziM49VK@bol.com.br> you wrote:
>
> I'm new to bdiGDB and I'm facing some problems with it. I've got a
> bdiGDB for a 82xx PPC and I've correctly updated its firmware and
> configured it through the RS232 interface, specifying its IP address,
> my host IP, bla bla bla. But when I try to communicate through the
> ethernet, by a telnet section, it doesn't seem to respond at all.
...
> IP Addr  : 192.168.0.2
> Subnet   : 255.255.255.255

Try setting a valis subnet mask, like 255.255.255.0

> - Do I need to have my target conected to bdi in order to
>   stabilish the telnet connection?

No.

> - What about the tftp server, does it have to be running at
>   this point?

Yes, or the BDI2000 will not be able to load the  board  config  file
and  the  register  description  file.  But  it  will  allow a telnet
connection, and complain if the TFTP server does not work.

> - What services are provided by the bdi? Telnet on TCP port 23?

Yes.

>   ICMP also? And what about the debugger, does it listen to

At least it will reply to ping.

>   port 2001?

Yes.

> - How can I get it running?

See above: netmask.

> Well, sorry by flooding the list with this newbie and OT message 8) And
> of course, I'd appreciate some help.

You are welcome.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A complex system that works is invariably found to have evolved from
a simple system that worked."             - John Gall, _Systemantics_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
