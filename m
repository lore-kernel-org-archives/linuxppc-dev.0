Date: Tue, 25 Jul 2000 10:02:39 -0400 (EDT)
From: John Grimes <jpgrimes@johngrimes.dyndns.org>
To: daenzerm@student.ethz.ch
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
In-Reply-To: <397D98EC.2E9C36C3@relog.ch>
Message-ID: <Pine.LNX.4.21.0007250957380.1469-100000@johngrimes.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Does the console work there? If yes, just don't specify any modelines and it
> will use the console mode.


Nope, console doesn't work for the 2nd monitor so suspect a config issue
on my side.  Will continue to work on.  Although how would I even get to
the 2nd monitor on the console, will moving the mouse get me there?  Or is
it higher console numbers?

Although I should add the console does work for the main r128 driven
monitor and using fbset I can change modes.

>
> And beware: With Xinerama, all screens must have the same depth...
>
yup, knew that, X is so painful with colors anyway I wouldn't even know
how some one could do this otherwise (imagine an 8 bit with a 32 bit
monitor, what would happen with taht color map when it swicthed windows :)


				thanks,
				John

>
> Michel
>
>
>

--
           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
