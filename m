Return-Path: <wd@denx.de>
To: stefan.eletzhofer@inquant.de
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Jan 2006 14:08:05 +0100."
	<1136380085.15908.15.camel@localhost>
Date: Wed, 04 Jan 2006 14:36:18 +0100
Sender: wd@denx.de
Message-Id: <20060104133618.0020E352B1E@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: "argument list too long" 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1136380085.15908.15.camel@localhost> you wrote:
> 
> > +	find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print | xargs scripts/mkdep -- > .hdepend
> >  	scripts/mkdep -- init/*.c > .depend
> 
> Would'nt this overwrite .depend if xargs executes mkdep more than once?

No, why should it? The filr eredirection happens just  once,  in  the
shell,  even before xargs gets executed. It does not matter how often
mkdep gets called then.

> I'd suggest (beware, manually hacked diff ;):

I have no idea what you're trying to fix or improve with this.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
For every complex problem, there is a solution that is simple,  neat,
and wrong.                                               - Mark Twain
