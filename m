To: Sam Ravnborg <sam@ravnborg.org>
Cc: Richard Danter <richard.danter@ntlworld.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Simple module, but won't build 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 May 2004 23:15:08 +0200."
             <20040504211508.GA2510@mars.ravnborg.org>
Date: Tue, 04 May 2004 23:46:18 +0200
Message-Id: <20040504214623.49B32C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040504211508.GA2510@mars.ravnborg.org> you wrote:
>
> make -C $KERNELSRCDIR SUBDIRS=$PWD modules
>
> This should give you the correct gcc options.
>
> [Speaking of vanilla kernel, not knowing ELDK in this respect].

Same for ELDK. We use a standard Linux kernel,  too  [just  some  bug
fixes and extensions included].

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
