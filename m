Date: Sun, 5 Sep 1999 16:43:42 -0400 (EDT)
From: mail <picasso@madflower.com>
To: "Paul J. Schinder" <schinder@pobox.com>
cc: John Bryan <johnb@austin.rr.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TCP module for perl
In-Reply-To: <199909051135.EAA17349@goose.prod.itd.earthlink.net>
Message-ID: <Pine.LNX.4.10.9909051639220.7380-100000@phish.madflower.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did you check out cpan.org to see if there was a perl module for what your
actually trying to do?


On Sun, 5 Sep 1999, Paul J. Schinder wrote:

> 
> On Sun, 05 Sep 1999 01:12:50 -0500, John Bryan wrote:
> >
> >
> >Howdy,
> >
> >I am looking for a TCP module to use with the Perl
> >install that comes with LinuxPPC 1999.
> >
> >At work for Solaris I have it referenced as tcp.pl
> 
> This looks to be something that is homegrown, especially considering that
> from the path below it's kept in a non-standard place.
> 
> >
> >I am trying to do something like:
> >
> >-------
> >#!/usr/bin/perl
> >
> >use Socket;
> >
> >require "/usr/local/bin/tcp.pl";  <----don't have
> 
> One solution is to simply grab a copy fron work. It's just a text file.
> 
> >
> >if (open_TCP(F, $ARGV[0], 1411) == undef) {
> >    print "Error connecting to server at $ARGV[0]\n";
> >    exit(-1);
> >}
> >
> >print F "GET http://some.domain.com HTTP/2.0\n\n";
> >-------
> 
> An experienced Perl user would say:
> 
> use LWP::Simple;
> get "http://some.domain.com";
> 
> >
> >When I try without the 'require' it says the open_TCP
> >subroutine is undefined, so I don't have the tcp.pl
> >apparently.
> >
> >It is not on my Linux install, at least not under /usr,
> >and the FAQ-o-matic didn't turn up anything on it.
> >
> >I will keep digging around 'the usual places' and see
> >what I might turn up, but if anyone knows where I can
> >pick this up for LPPC, I'd sure appreciate it.
> 
> When digging for things Perl, start at cpan.perl.org. Learn about CPAN and
> how to use it. You'll almost always find what you need there.
> 
> >
> >Thanks,
> >JB
> >
> >
> 
> 
> 
> -------
> Paul J. Schinder
> schinder@pobox.com
> 
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
