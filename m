To: Chris Clark <linuxppc-embedded@2nerds.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Relationship between bk libuxppc-2.4 and denx linuxppc_2_4_devel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jun 2004 14:59:48 MDT."
             <Pine.GSO.4.53.0406111437580.9184@solaris.xmission.com>
Date: Fri, 11 Jun 2004 23:58:23 +0200
Message-Id: <20040611215828.C8735C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.GSO.4.53.0406111437580.9184@solaris.xmission.com> you wrote:
>
> Unless I made some mistake in cloning the linuxppc-2.{4,5} trees from
> ppc.bkbits.net, (which is entirely possible as I'm a BK newbie), there
> appears to be a fair amount of processor- and platform-specific stuff
> in the Denx linuxppc_2_4_devel CVS tree which does not appear in the
> ppc.bkbits.net BK trees (e.g. arch/ppc/5xxx_io/... ).

Your finding is correct.

> Is the Denx CVS tree "authoritative" with regard to those extras?  Is

No, not at all. It's just what we're doing here at DENX.

> there any expectation that those bits found only in the Denx CVS tree
> will eventually find their way into the ppc.bkbits.net tree(s)?  (Or
> some other, more appropriate tree(s)?  If so, which?)

I gave up submitting patches - probably my communication  skills  are
inadequate.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Testing can show the presense of bugs, but not their absence.
                                                   -- Edsger Dijkstra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
