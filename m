Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C7B9F2E.40BC7C46@lvl7.com>
Date: Tue, 26 Feb 2002 09:43:58 -0500
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: David Ashley <dash@xdr.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
References: <200202260315.g1Q3Fmt18809@dave.home> <3C7B0605.3080308@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Could you elaborate on the problems associated w/ bus timings that
you've seen on the 8xx?  We've been seeing a lot of unexplained Oops
messages (and even crashes) on one of our hardware platforms.  The only
common thread seems to be dereferncing bad pointer values, but they
occur in so many different places...

I've asked our hardware guys to take a look at the settings for the UPM
we are using to control SDRAM.  Do you think we are on the right track?
Can you provide any guidance?

Thanks in advance for any help you can provide!  I'll buy you a beer and
some maple candy the next time I'm up your way! :-)

John

Dan Malek wrote:
>
> David Ashley wrote:
>
> > Maybe you can point me to some discussion of how linux operates? I mean,
> > once the memory is mapped with the page tables, what happens once the
> > process does a read to a page? Does that generate a page fault?
>
> It isn't really unique to Linux.  Yes, the access can generate a page
> fault, which will cause a kernel exception to load the TLB.  This can
> generate some weird looking, early terminated bus timing, which is
> perfectly within the specifications of the hardware but isn't something
> the designers always consider.  I've seen this quite often on the 8xx,
> but fortunately have never had to attach a logic analyzer to a 60x bus.
>
> So, I doubt it is any Linux or software problem, but more likely something
> wrong with the timing on the bus that is resulting in incorrect data
> returned to a memory access.

--
John W. Linville
LVL7 Systems, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
