Message-ID: <37D209E2.873EDD17@austin.rr.com>
Date: Sun, 05 Sep 1999 01:12:50 -0500
From: John Bryan <johnb@austin.rr.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: TCP module for perl
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy,

I am looking for a TCP module to use with the Perl
install that comes with LinuxPPC 1999.

At work for Solaris I have it referenced as tcp.pl

I am trying to do something like:

-------
#!/usr/bin/perl

use Socket;

require "/usr/local/bin/tcp.pl";  <----don't have

if (open_TCP(F, $ARGV[0], 1411) == undef) {
    print "Error connecting to server at $ARGV[0]\n";
    exit(-1);
}

print F "GET http://some.domain.com HTTP/2.0\n\n";
-------

When I try without the 'require' it says the open_TCP
subroutine is undefined, so I don't have the tcp.pl
apparently.

It is not on my Linux install, at least not under /usr,
and the FAQ-o-matic didn't turn up anything on it.

I will keep digging around 'the usual places' and see
what I might turn up, but if anyone knows where I can
pick this up for LPPC, I'd sure appreciate it.

Thanks,
JB

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
