To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JTAG debug mechanism 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 13 Aug 2004 10:55:44 EDT."
             <004301c48145$a072a150$0301a8c0@chuck2>
Date: Fri, 13 Aug 2004 19:18:56 +0200
Message-Id: <20040813171901.77C64C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <004301c48145$a072a150$0301a8c0@chuck2> you wrote:
>
> Motorola does not release all the information about the debug interface on
> all their processors.  However, the

Well, they do (or it would be impossible to build  devices  like  the
BDI2000), but only under NDA.

> BDM interface is well documented, and there is an open source project called
> bdm4gdb.sourceforge.net, which

...and this NDA also prevents us from implementing  COP  support  for
BDM4GDB  [at  least when basing the software on GDB which requires it
to be GPLed] :-(

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
