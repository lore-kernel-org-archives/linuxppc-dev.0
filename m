To: Jeff Mintz <jmintz@ghs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Network problem when using jtag debugger on EP8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Nov 2003 15:14:49 PST."
             <3FBE9C69.36C74D2F@ghs.com>
Date: Sun, 23 Nov 2003 22:38:15 +0100
Message-Id: <20031123213820.F257CC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jeff,

in message <3FBE9C69.36C74D2F@ghs.com> you wrote:
>
> > We implemented a workaround once, but I don;t think we checked it  in
> > into  our  source  tree  because  it  involves  a certail performance
> > overhead (although it was quite useful during debugging).
> >
> > If you're interested I think I can dig it out again.
>
> I would be very interested in the workaround, if you can dig it out.  It would
> be very helpful for our development.  Please send it, if you can.

I've put the patch on our FTP server. Please see

	ftp://ftp.denx.de/pub/patches/README.fcc_cache
	ftp://ftp.denx.de/pub/patches/fcc_cache.patch

Hope it helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quantum particles: The dreams that stuff is made of.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
