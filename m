To: Darin.Johnson@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc vs. newlib 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 04 Apr 2003 15:08:26 -0800."
             <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
Date: Sat, 05 Apr 2003 01:38:24 +0200
Message-Id: <20030404233829.466A8C587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com> you wrote:
>
> What are the experiences and tradeoffs of using newlib vs. glibc?  I'm targetting 16M board (maybe some 8M), no swap space, and I'm concerned that adding glibc will suck much of this up.  At the same time we'd also like to be able to use off-the-shelf c
> omponents like dhcpd or telnetd, and are not sure if newlib would give us too many headaches there.

newlib is probably not sufficient for any practical purposes.

OTOH 16 MB of RAM are sufficient to even run GCC on  the  target,  so
woth  a  bit of careful tuning a LOT can be done using plain glibc. I
recommend to start with glibc; if you;re running out of space try  to
optimize it, and only when this fails start looking for alternatives.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only person who always got his work done by Friday
                                                 was Robinson Crusoe.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
