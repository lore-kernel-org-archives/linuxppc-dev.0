To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jul 2003 09:21:41 +0300."
             <3F124BF5.6070803@intracom.gr>
Date: Mon, 14 Jul 2003 09:58:05 +0200
Message-Id: <20030714075810.D95FAC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Pantelis,

in message <3F124BF5.6070803@intracom.gr> you wrote:
>
> >>IIRC the last time we such discussions simply nothing  happened:  see
> >>for example to code for dp_alloc / dp_free that was submitted several
> >>times.
> >
> >google knows nothing of this, can you give a pointer into the thread
> >please?  Thanks.
> >
> >
> I was the one that sent the patches (search for dpalloc).

I was referring to a much older implementation  of  this  feature.  I
sent it to Tom nearly two years ago:

	Subject: Re: Modifications to linuxppc_2_4_devel
	From: Wolfgang Denk <wd@denx.de>
	Date: Wed, 29 Aug 2001 23:57:30 +0200
	To: Tom Rini <trini@kernel.crashing.org>

The patch in question was named "PATCH-006-dpfree+uart".


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Ever try. Ever fail. No matter. Try again. Fail again.  Fail  better.
                                                        -- S. Beckett

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
