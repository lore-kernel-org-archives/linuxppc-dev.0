To: Tom Rini <trini@kernel.crashing.org>
Cc: Stephen Cameron <steve.cameron@hp.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bitkeeper trouble 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 May 2002 15:21:06 PDT."
             <20020528222106.GC5997@opus.bloom.county>
Date: Wed, 29 May 2002 00:33:14 +0200
Message-Id: <20020528223319.BCE1011973@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020528222106.GC5997@opus.bloom.county> you wrote:
>
> What does 'bk parent' say?  If it's not
> bk://ppc.bkbits.net/linuxppc_2_4_devel, try doing:
> bk parent bk://ppc.bkbits.net/linuxppc_2_4_devel
> and then pulling again.  I'm not sure why, but ppc.bkserver.net seems to
> be gone.

Well, from here it looks like a name server problem:

Non-authoritative answer:
Name:   ppc.bkserver.net
Address: 10.3.9.222

This explains why I get "no route to host" errors...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human mind treats a new idea the way the body  treats  a  strange
protein - it rejects it.                                 - P. Medawar

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
