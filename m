Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Mark Hatle <fray@mvista.com>,
	Srini Amble <samble@xopnetworks.com>
Subject: Re: thttpd and CGI on MPC 850
Date: Wed, 2 Apr 2003 23:17:33 -0300
Cc: linuxppc-embedded@lists.linuxppc.org
References: <200304021423.33094.samble@xopnetworks.com> <3E8B63DF.5010706@mvista.com>
In-Reply-To: <3E8B63DF.5010706@mvista.com>
MIME-Version: 1.0
Message-Id: <200304022317.33294.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 02 April 2003 19:27, Mark Hatle wrote:
> Srini Amble wrote:
> > Pardon me for posting this message to this mailing list ( it does not
> > quite belong here)
> >
> > I have "thttpd" (version 2.23beta1) running on my MPC850 board. When I
> > submit a "FORM" which in turn invokes a CGI program (written in C) the
> > console output freezes and I get the error "An error occurred while
> > loading http://192.168.0.128/cgi-bin/example.cgi" on the browser window.

Just a wilg guess: did you check file permissions?

HTH,

-Scop.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
