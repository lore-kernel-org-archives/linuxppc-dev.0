Subject: Re: dmasound audio patch
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Bill Fink <billfink@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-general@lists.terrasoftsolutions.com
In-Reply-To: <20020408084102.195d67bd.billfink@mindspring.com>
References: <20020407172358.36f3fd3e.billfink@mindspring.com>
	<1018261838.1870.7347.camel@tibook>
	<20020408084102.195d67bd.billfink@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Apr 2002 14:50:52 +0200
Message-Id: <1018270252.1870.8601.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-04-08 at 14:41, Bill Fink wrote:
> On 08 Apr 2002, Michel Dänzer wrote:
>
> > On Sun, 2002-04-07 at 23:23, Bill Fink wrote:
> > >
> > > A friend of mine, Rob Scott, worked up a patch to the dmasound driver
> > > that fixes some of the PPC endianness issues by doing byte swapping
> > > in the driver.  He uses it on a Titanium PowerBook, and I am using it
> > > on a dual 500 MHz G4 with good results.  Before the patch, using xmms
> > > with the AudioCD Reader plugin, I had to use the esound driver since
> > > the OSS driver just gave static.  Now I can use the OSS driver directly,
> > > so there's no need to run the esd daemon.
> >
> > Must be an old version of xmms? It swaps bytes if necessary since 1.2.5
> > or so.
>
> Hi Michel,
>
> That's good to know.  I was using xmms-1.2.4 that came with YDL 2.1,
> but I see that YDL 2.2 has xmms-1.2.5, so I'll give that a try.

Hmm, looking at our xmms changelog, the endianness fixes may only be in
1.2.6 or later. YMMV.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
