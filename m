Message-ID: <3E8B63DF.5010706@mvista.com>
Date: Wed, 02 Apr 2003 16:27:43 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Srini Amble <samble@xopnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: thttpd and CGI on MPC 850
References: <200304021423.33094.samble@xopnetworks.com>
In-Reply-To: <200304021423.33094.samble@xopnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Srini Amble wrote:
> Pardon me for posting this message to this mailing list ( it does not quite
> belong here)
>
> I have "thttpd" (version 2.23beta1) running on my MPC850 board. When I submit
> a "FORM" which in turn invokes a CGI program (written in C) the console
> output freezes and I get the error "An error occurred while loading
> http://192.168.0.128/cgi-bin/example.cgi" on the browser window. The board is
> alive because I can ping the board. I can execute the CGI program on the
> shell without any problem. I would appreciate any wisdom from the community
> at large which will help me in debugging this problem.
>
> BTW, Identical set of "thttpd", CGI program, and HTML pages works fine on an
> x86 RH 7.3 host.

thttpd's error handing is far from useful.  Do what I have had to do in the
past.  Go into the thttpd source code and add verbose debugging..  Usually the
problem comes down to missing libraries or something minor like that.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
