Date: Mon, 8 Apr 2002 08:41:02 -0400
From: Bill Fink <billfink@mindspring.com>
To: Michel D?nzer <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: dmasound audio patch
Message-Id: <20020408084102.195d67bd.billfink@mindspring.com>
In-Reply-To: <1018261838.1870.7347.camel@tibook>
References: <20020407172358.36f3fd3e.billfink@mindspring.com>
	<1018261838.1870.7347.camel@tibook>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 08 Apr 2002, Michel Dänzer wrote:

> On Sun, 2002-04-07 at 23:23, Bill Fink wrote:
> >
> > A friend of mine, Rob Scott, worked up a patch to the dmasound driver
> > that fixes some of the PPC endianness issues by doing byte swapping
> > in the driver.  He uses it on a Titanium PowerBook, and I am using it
> > on a dual 500 MHz G4 with good results.  Before the patch, using xmms
> > with the AudioCD Reader plugin, I had to use the esound driver since
> > the OSS driver just gave static.  Now I can use the OSS driver directly,
> > so there's no need to run the esd daemon.
>
> Must be an old version of xmms? It swaps bytes if necessary since 1.2.5
> or so.

Hi Michel,

That's good to know.  I was using xmms-1.2.4 that came with YDL 2.1,
but I see that YDL 2.2 has xmms-1.2.5, so I'll give that a try.

						-Thanks

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
