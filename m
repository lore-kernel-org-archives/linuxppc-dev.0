Content-Type: text/plain;
  charset="us-ascii"
From: Srini Amble <samble@xopnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: thttpd and CGI on MPC 850
Date: Wed, 2 Apr 2003 14:23:33 -0600
MIME-Version: 1.0
Message-Id: <200304021423.33094.samble@xopnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pardon me for posting this message to this mailing list ( it does not quite
belong here)

I have "thttpd" (version 2.23beta1) running on my MPC850 board. When I submit
a "FORM" which in turn invokes a CGI program (written in C) the console
output freezes and I get the error "An error occurred while loading
http://192.168.0.128/cgi-bin/example.cgi" on the browser window. The board is
alive because I can ping the board. I can execute the CGI program on the
shell without any problem. I would appreciate any wisdom from the community
at large which will help me in debugging this problem.

BTW, Identical set of "thttpd", CGI program, and HTML pages works fine on an
x86 RH 7.3 host.

Thanks in advance
--
Srini Amble

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
