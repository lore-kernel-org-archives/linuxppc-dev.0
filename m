From: jtm@smoothsmoothie.com
Date: Wed, 6 Feb 2002 11:48:38 -0600
To: murali nagarajan <muralin@gdatech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems running PING, Telnet
Message-ID: <20020206174838.GA8587@shamus.smoothsmoothie.com>
References: <020c01c1ae90$d47efbe0$0900a8c0@Domain.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <020c01c1ae90$d47efbe0$0900a8c0@Domain.invalid>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 05, 2002 at 02:02:32PM -0800, murali nagarajan wrote:
>                                    ----------
> - PING command does not work
>   The erro message I get is   "ping: unknown protocol icmp"

Do you have the libnss_* stuff in /lib? I think not having it is
the source of your problem.

> - Telnet program does not work which tells me that the service is unknown.
>    The error message I get is "telnet: tcp/telnet: unknown service"

This might be related to the above, but I'm not sure.

--
Jay Monkman	    The truth knocks on the door and you say "Go away, I'm
monkman@jump.net    looking for the truth," and so it goes away. Puzzling.
		     - from _Zen_and_the_Art_of_Motorcycle_Maintenance_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
