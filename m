Message-Id: <200102221603.f1MG3k716096@ashley.ivey.uwo.ca>
Date: Thu, 22 Feb 2001 11:03:45 -0500
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: do md5sums differ across architectures?
Cc: linuxppc-dev@lists.linuxppc.org
To: Ethan Benson <erbenson@alaska.net>
Mime-Version: 1.0 (Apple Message framework v337)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

No, ftping in binary.

I am running textutils-2.0e6 rpm (the latest) from www.linuxppc.org which supplies
md5sum

I will check what I am running on Solaris.

hmm, I wonder which one is broken?

Thanks,

Kevin

On Thursday, February 22, 2001, at 10:49 AM, Ethan Benson wrote:

> On Thu, Feb 22, 2001 at 10:24:01AM -0500, Kevin B. Hendricks wrote:
> >
> > Hi,
> >
> > I ran md5sum on a big bz2 archive on my ppc linux box and then
> > ftp'd it to my Sun Solaris 7 box at work.
> >
> > I checked it with md5sum on that machine and it differed.
> >
> > Okay I thought, a bad packet during upload.
> >
> > So I tried again, same result.
> >
> > I then passed back and forth (known good archives) and the md5sums
> > were different.
> >
> > Okay, I thought maybe an endian issue but both Solaris Sparc and PPC
> > Linux are big endian.
> >
> > Should these sums be different?
>
> no, that would rather defeat the purpose of md5sum hashes.  one of
> your md5sum programs is broken.
>
> or perhaps you ftp'd in text mode instead of binary mode.
>
> --
> Ethan Benson
> http://www.alaska.net/~erbenson/
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
