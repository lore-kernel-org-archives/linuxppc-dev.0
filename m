Date: Tue, 5 Feb 2002 14:53:07 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: murali nagarajan <muralin@gdatech.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with ping/telnet
In-Reply-To: <022601c1ae91$34c80820$0900a8c0@Domain.invalid>
Message-ID: <Pine.LNX.3.96.1020205145050.16943C-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Feb 2002, murali nagarajan wrote:

> - PING command does not work
>   The erro message I get is   "ping: unknown protocol icmp"

Don't know.  Might be a kernel compile issue or something, or it might be
related to the second issue.  Not sure.


> - Telnet program does not work which tells me that the service is unknown.
>    The error message I get is "telnet: tcp/telnet: unknown service"

This one's easy.  Telnet explicitly asks the system for the default port
number for telnet service.  If you don't have a valid /etc/services file
(with telnet listed), it won't be able to do so, and it will fail.  If you
specify a port number by hand (e.g. telnet foo.com 23), it should work.
Or you can just put in an /etc/services file.


Later,
David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
