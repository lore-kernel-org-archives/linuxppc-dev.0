Date: Fri, 09 Mar 2001 18:15:03 +0000
Subject: provision of "driver" type facilities from user-space
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010309181506.CB5212F00E@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi list,

I want to put a layer in between user-space and a driver (dmasound).

The reason is - that I want to provide facilities (transparently) to
applications and these facilities cannot be (sensibly) placed in the driver
[e.g. rate conversion and so on].

In this case to make dmasound look like it can do "anything" and help
support (easily) apps that don't really bother to check for h/w capabilities
properly.

It isn't really the best solution to bloat each and every app with code to
do the job - some form of sharing seems to be the right way.

so solution 1:

provide a pseudo-oss interface via a library:

psuedo_oss_open(), pseudo_oss_read() .... etc. etc.

so app source is amended and then linked with a lib providing the
appropriate stuff in user-space...

not, probably, going to be popular...

solution 2:

??? is there a way of doing this without the apps being amended but _still_
making sure that code that belongs in user-space resides and is executed
there?

preferably allowing apps to think they are just talking to /dev/dsp

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
