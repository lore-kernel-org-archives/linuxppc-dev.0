Message-ID: <3834AED6.60CEFA8D@ctam.com.au>
Date: Fri, 19 Nov 1999 12:58:46 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        linux-embedded <linux-embedded@waste.org>
Subject: Re: Building 'mount' for an embedded system
References: <38333C71.3FFD50E@ctam.com.au> <kfyiu2z7wby.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Marcus Sundberg wrote:

> Brendan Simon <bsimon@ctam.com.au> writes:
>
> > I read README.mount which said mount was presently maintained by Andries
> > Brouwer <aeb@cwi.nl> and the ftp site is ftp.win.tue.nl/pub/linux/util.
> >
> > I downloaded
> > ftp://ftp.win.tue.nl/pub/linux/utils/util-linux/util-linux-2.10b.tar.gz
> > which had some of the missing files but not all of them.
>
> It would help if you told what files are missing.

It was make_include.  I thought I had executed configure but I objviously
didn't.


> I built mount from one of the 2.9 versions of util-linux without
> problems.

Did you compile on a native powerpc system or did you use a cross-compiler ?

I think the problem I am having is that configure is not setup to support
cross-compilation.  I have got a little further now by massaging the MCONFIG
file and the generate make_include file.  I will have a go at editing the
configure script and submit any changes to the utils-linux maintainer.  I
will also let the linux-embedded mailing lists know of my results.

Thanks,
Brendan Simon.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
