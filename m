To: "Ashwin Bihari" <raz0redge@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded initrd with static programs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Dec 2003 10:04:57 EST."
             <BAY9-F37onNzN9rvBmW0007186b@hotmail.com>
Date: Tue, 23 Dec 2003 16:56:11 +0100
Message-Id: <20031223155616.3F20EC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY9-F37onNzN9rvBmW0007186b@hotmail.com> you wrote:
>
> So basically I need the other two programs also statically compiled, does
> anyone of any idea on how I would go about this??

Edit the relevant Makefile and add "-static" to the compiler options?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"This is a test of the Emergency Broadcast System. If this had been an
actual emergency, do you really think we'd stick around to tell you?"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
