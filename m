To: "Collins, Steve" <Steve.Collins@dynetics.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <'linuxppc-embedded@lists.linuxppc.org'>
Subject: Re: creating /dev/log 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Sep 2003 15:26:11 CDT."
             <45E73EE17E678C4081B8A09E651628D2524F78@atlas.info-engineering.com>
Date: Wed, 10 Sep 2003 22:55:18 +0200
Message-ID: <19xCOx-2AEtHM0@fmrl06.sul.t-online.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <45E73EE17E678C4081B8A09E651628D2524F78@atlas.info-engineering.com> you wrote:
>
> Would someone tell me how to create the socket /dev/log for syslogd?

Make a socket? Well, maybe "mksock /dev/log" will do the trick?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When all is said and done, more is said than done.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
