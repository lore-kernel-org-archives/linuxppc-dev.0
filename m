To: Pantelis Antoniou <panto@intracom.gr>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 17:16:54 +0300."
             <40C9BED6.3010809@intracom.gr>
Date: Fri, 11 Jun 2004 16:43:18 +0200
Message-Id: <20040611144323.F293AC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40C9BED6.3010809@intracom.gr> you wrote:
>
> OK, lets look at the very simple problem of having two
> ethernet interfaces. From where do I get the ethernet
> mac addresses? Modifying bd_t with defines is gross.

This is hardware dependend. For  example,  on  some  boards  the  MAC
addresses are simply sequential - so you just add one :-)

> Putting everything on the kernel command line results in
> an unreadable command line.

Agreed. The command  line  is  another  bad  solution  to  pass  such
information.

> Yeah, having the bi_recs interface actually working
> would be ideal, but at the present time nothing is
> working and as AFAIK no-one is working on it.

Mark A. Greer made a  nice  proposal  more  than  2  years  ago.  See
discussion  that  started  as  "EV-64260-BP & GT64260 bi_recs" around
March 19, 2002.

I'd be happy to see this accepted.

> I have to have something working now and IMO just reading
> the u-boot environment is the fastest solution.

OK - accepted. But it's a quick and dirty  hack,  and  not  something
that should go into a public tree.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Microsoft Multitasking:
                     several applications can crash at the same time.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
