Date: Mon, 8 Apr 2002 10:14:43 -0400
From: Bill Fink <billfink@mindspring.com>
To: Michel D?nzer <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: dmasound audio patch
Message-Id: <20020408101443.01f48537.billfink@mindspring.com>
In-Reply-To: <1018270252.1870.8601.camel@tibook>
References: <20020407172358.36f3fd3e.billfink@mindspring.com>
	<1018261838.1870.7347.camel@tibook>
	<20020408084102.195d67bd.billfink@mindspring.com>
	<1018270252.1870.8601.camel@tibook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 08 Apr 2002, Michel Dänzer wrote:

> On Mon, 2002-04-08 at 14:41, Bill Fink wrote:
> > On 08 Apr 2002, Michel Dänzer wrote:
> >
> > > Must be an old version of xmms? It swaps bytes if necessary since 1.2.5
> > > or so.
> >
> > Hi Michel,
> >
> > That's good to know.  I was using xmms-1.2.4 that came with YDL 2.1,
> > but I see that YDL 2.2 has xmms-1.2.5, so I'll give that a try.
>
> Hmm, looking at our xmms changelog, the endianness fixes may only be in
> 1.2.6 or later. YMMV.

Well even the just released YDL 2.2 only has xmms-1.2.5, which is still
broken.  For the record, I did get the Rawhide xmms-1.2.7 source RPM and
did an "rpm --rebuild" on it, and can report that xmms-1.2.7 does in fact
work fine, but that was a fair amount of work and time.  I'm still going
to stick with my friend's dmasound kernel patch, so I don't have to go
through all this for the next sound app I might happen to try that's not
yet endianness aware.

						-Thanks

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
