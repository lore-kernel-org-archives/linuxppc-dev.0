Message-ID: <3906E062.EB20B459@relog.ch>
Date: Wed, 26 Apr 2000 14:26:10 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004240616.XAA02709@pop3.ucdavis.edu>
	 <39058023.39877695@relog.ch> <3905650C.FBCBB453@ucdavis.edu>
	 <3905CD24.A0FC8A9F@relog.ch> <3905E436.124D745E@ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:

> I modified the config file you sent me to use the secondary monitor only
> (since XFree wouldn't parse the dual monitor layout section),

Dang, gotta look at the syntax for the Layout Section again :)

BTW you can quickly choose a Screen Section with the -screen command line
option.


> and unfortunately the kernel still crashed. Right now trying to get
> both monitors working is getting ahead of myself - i'm first shooting to get
> the secondary one working alone.

Very sensible.

> Unfortunately, the XFree86 4.0 docs say that PCI id's are mandatory for
> dual-head configs.

So? You have specified them.

> Oh and it dies before it writes to the logfile. So I have no clue what to do
> next. Suggestions?

- remount (at least) the partition containing /var/log in sync mode (to get at
  least something from the log)

- run X with -probeonly


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
