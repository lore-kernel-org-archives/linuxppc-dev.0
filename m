To: Brian Hawley <bhawley@luminex.com>
Cc: Gerhard Jaeger <g.jaeger@sysgo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony Board, PPC440GP and NFS panics 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 May 2004 09:13:59 PDT."
             <4.2.2.20040519091201.05090ce0@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 19:59:15 +0200
Message-Id: <20040519175920.37BA5C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.2.2.20040519091201.05090ce0@bhawley.mailhost.luminex.com> you wrote:
>
...
> come out.  We think that is because linux is thinking the MAC address is
> ff:ff:ff:ff:ff:ff instead of what
> it really is.  u-boot doesn't seem to have a problem getting the MAC
> address out of the ebony board, but
> this linux kernel seems to.

U-Boot passes the MAC address to the Linux kernel, so if your  kernel
is  configured  for use with U-Boot, then it will pick up the correct
MAC address. Maybe it is not?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No one may kill a man.  Not for any purpose.  It cannot be condoned.
	-- Kirk, "Spock's Brain", stardate 5431.6

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
