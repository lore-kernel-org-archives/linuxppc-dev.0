To: Pantelis Antoniou <panto@intracom.gr>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 14:03:30 +0300."
             <40C99182.8050201@intracom.gr>
Date: Fri, 11 Jun 2004 15:03:04 +0200
Message-Id: <20040611130309.6E605C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40C99182.8050201@intracom.gr> you wrote:
>
[David Woodhouse:]

> >We really need to throw this crap away and start using structured tags
> >like ARM does.

Right (or bi_rec's or whatever this might end up being called).

> Or we can parse the u-boot environment which is ascii.
> I already do this...

No, this is IMHO not a good idea. Some of the information that  needs
to  be  passed to the kernel is not contained in the envrionment, and
does not belong there.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Sendmail may be safely run set-user-id to root.
                        -- Eric Allman, "Sendmail Installation Guide"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
