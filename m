Subject: Re: libXrender bug crashes OpenOffice
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <87g06zkc8y.fsf@openinformatics.com>
References: <87u1vfkfgt.fsf_-_@openinformatics.com>
	<1006902937.5468.25.camel@pismo>  <87g06zkc8y.fsf@openinformatics.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 28 Nov 2001 01:27:39 +0100
Message-Id: <1006907259.5347.29.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2001-11-28 at 00:47, Jason E. Stewart wrote:
>
> "Michel Dänzer" <michdaen@iiic.ethz.ch> writes:
>
> > On Tue, 2001-11-27 at 23:37, Jason E. Stewart wrote:
> >
> > > While running Kevin Hendrix's build of OpenOffice I kept getting
> > > Abort's for no reason. We've finally limited down to the Xrender
> > > lib. When it's not on my system, OpenOffice runs fine, with it I get
> > > crashes.

BTW how can I reproduce those crashes? No 'success' so far.


> > > Kevin found a bug in the library and fixed it and OpenOffice runs fine
> > > on his system with libXrender installed. I downloaded the latest xlibs
> > > source from sid and checked, but his patch hasn't yet been
> > > included.
> > >
> > > Will it be included soon?
> >
> > Err... and what does that have to do with Linux/PPC development? ;)
>
> Perhaps I was mistaken, but I thought that the bug only existed on
> PPC. Is this too X-specific and should be posted elsewhere?

At least I didn't see anything PPC specific in the fix you posted.

In particular though, you should submit this in a bug against the Debian
xlibs package for it to be included there.

AFAIK the fix has already been applied to the XFree86 CVS trunk, so it
will be in the 4.2.0 release. Don't know about the 4.1 branch.


PS: No, you can't build only libXrender.

--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
