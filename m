Message-ID: <3905E436.124D745E@ucdavis.edu>
Date: Tue, 25 Apr 2000 14:30:14 -0400
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
MIME-Version: 1.0
To: daenzerm@student.ethz.ch
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004240616.XAA02709@pop3.ucdavis.edu>
		 <39058023.39877695@relog.ch> <3905650C.FBCBB453@ucdavis.edu> <3905CD24.A0FC8A9F@relog.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Michel for your help :-). I modified the config file you sent me to use
the secondary monitor only (since XFree wouldn't parse the dual monitor layout
section), and unfortunately the kernel still crashed. Right now trying to get
both monitors working is getting ahead of myself - i'm first shooting to get the
secondary one working alone. Unfortunately, the XFree86 4.0 docs say that
PCI id's are mandatory for dual-head configs. Oh and it dies before it writes to
the logfile. So I have no clue what to do next. Suggestions?

- Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
