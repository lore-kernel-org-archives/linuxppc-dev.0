To: Tom Rini <trini@kernel.crashing.org>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Dan Malek <dan@embeddededge.com>,
	Ibon Gotxi Garcia <igotxi@jazzfree.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about modules 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Mar 2003 15:12:05 MST."
             <20030303221205.GA12414@ip68-0-152-218.tc.ph.cox.net>
Date: Mon, 03 Mar 2003 23:23:22 +0100
Message-Id: <20030303222327.D72CCC6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030303221205.GA12414@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> > In commproc.c, add the following line:
> >   EXPORT_SYMBOL(m8xx_cpm_hostalloc);
>
> I'll bite... Dan is there a good reason this isn't exported?  Google
> shows nothing to me :)

IMHO the only "good" reason they were not  exported  right  from  the
beginnng  is that the standard drivers that come with the kernel tree
cannot be built as modules anyway, so nobody needed it.

Please add.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A Perl script is correct if it's halfway readable and  gets  the  job
done before your boss fires you.
                       - L. Wall & R. L. Schwartz, _Programming Perl_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
