Subject: Re: Help with string.S
To: tom_gall@vnet.ibm.com
Date: Thu, 17 Aug 2000 10:50:57 +1000 (EST)
Cc: linuxppc-dev@lists.linuxppc.org (Linux PowerPC developers mailing list)
In-Reply-To: <399ABFBE.7278954E@vnet.ibm.com> from "tom_gall@vnet.ibm.com" at Aug 16, 2000 04:22:22 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000817005057.83E8FCD@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom,

Thanks for the response...

Graham Stoney wrote:
> I tried dropping in the new improved version from linux-2.4.0-test7-pre4,
> and none of the 8xx mods are in there: it'l only work for 32 byte cache
> lines.

tom_gall@vnet.ibm.com writes:
> That's not right. Which version of linux-2.4.0-x do you have? I'm sure Paul's,
> Cort's and and I know for sure mine work for more than 32 byte cache lines
> because 2 of my boxes have 128 byte cache lines and there's support in there
> for it. (Paul wrote it... awesome stuff)

I'm talking about linux-2.4.0-test7-pre4, from:
    http://www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.0-test6.tar.bz2
plus:
    http://www.kernel.org/pub/linux/kernel/testing/test7-pre4.gz

I believe this is the latest test snapshot of what will soon become the
official 2.4.  Is there some other repository I should be looking at for the
lastest ppc stuff?

> This isn't the only spot too by the way ... glibc has the some problem.

Yes, in sysdeps/powerpc/memset.S.  This is easily enough solved by nuking it,
and allowing glibc to use the generic C version.

> > It sounds like a few people have at least had a shot at adding support
> > for other than 32 byte cache lines, but none have propagated into the
> > official kernels; how does that happen anyway?
>
> By official are you meaning Linus' ?

Yes.  Do I need to run BitKeeper to keep up with the latest ppc changes?
They don't seem to be making it in to Linus's kernel...

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
