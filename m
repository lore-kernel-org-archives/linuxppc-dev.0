Message-Id: <200002082006.VAA12025@denx.local.net>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Josh Huber <huberj@wpi.edu>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BMAC eth problems...
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Feb 2000 07:22:45 CST."
             <38A018A5.FD10C45D@execpc.com>
Date: Tue, 08 Feb 2000 21:06:22 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

in message <38A018A5.FD10C45D@execpc.com> you write:
>
> My wallstreet/300 has a similar, possibly related problem.  any FTP transfer
> originating from my powerbook in Linux (under any client or server) has a max
> transfer under 100k.  This is a BMAC driver problem.  my brother's lombard

Same problem for me. Incoming traffic is fast and reliable,  outgoing
data  is  slow  (usually  around  80  k/s)  and large transfers often
contain garbage (bad data, but I cannot see any errors reported).

> MacOS has no problems with my ethernet card; incoming FTP transfers work normal;

Same here.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
				 EARTH
			     smog  |   bricks
			 AIR  --  mud  --  FIRE
			soda water |   tequila
				 WATER

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
