From: tom_gall@vnet.ibm.com
Message-ID: <399D3E9D.FB6F2AD2@vnet.ibm.com>
Date: Fri, 18 Aug 2000 13:48:13 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: greyham@research.canon.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Help with string.S]
References: <399D210E.9CA9913A@rochcivictheatre.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi Tom,
>
> Thanks for the response...

Hi Graham,

  Happy to help.

> Graham Stoney wrote:
> > I tried dropping in the new improved version from linux-2.4.0-test7-pre4,
> > and none of the 8xx mods are in there: it'l only work for 32 byte cache
> > lines.
>
> tom_gall@vnet.ibm.com writes:
> > That's not right. Which version of linux-2.4.0-x do you have? I'm sure Paul's,
> > Cort's and and I know for sure mine work for more than 32 byte cache lines
> > because 2 of my boxes have 128 byte cache lines and there's support in there
> > for it. (Paul wrote it... awesome stuff)
>
> I'm talking about linux-2.4.0-test7-pre4, from:
>     http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test6.tar.bz2
> plus:
>     http://www.kernel.org/pub/linux/kernel/testing/test7-pre4.gz

  Ah! That's why....

  ftp.kernel.org generally lags behind the PowerPC development tree. For the
latest there are a few sources to choose from. Generally the differences are
based on what people are working on.

  Cort's Tree: www.fsmlabs.com/linuxppcbk.html
  Paul's Tree: linuxcare.com.au/paulus/kernels.html
  My Tree: fsmlabs.com/~tgall

  Take a look at http://linuxppc.org ... very good collection of PowerPC info...


> Yes, in sysdeps/powerpc/memset.S.  This is easily enough solved by nuking it,
> and allowing glibc to use the generic C version.

Yes, exactly.

> > > It sounds like a few people have at least had a shot at adding support
> > > for other than 32 byte cache lines, but none have propagated into the
> > > official kernels; how does that happen anyway?
> >
> > By official are you meaning Linus' ?
>
> Yes.  Do I need to run BitKeeper to keep up with the latest ppc changes?
> They don't seem to be making it in to Linus's kernel...

I wouldn't say you *NEED* to run BK, as rsync works just fine.

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
