From: Barrie Spence <barrie@calvin.demon.co.uk>
Message-Id: <199906231856.TAA02677@calvin.demon.co.uk>
Date: Wed, 23 Jun 1999 18:56:02 +0000 (GMT)
To: linuxppc-dev@lists.linuxppc.org
Cc: puetzk6715@uni.edu
Subject: Re[2]: ppp compression module aliases?
In-Reply-To: <Pine.PMDF.3.96.990622120549.539020675E-100000@uni.edu>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


puetzk6715@uni.edu wrote:
> 
> The easiest way to get all this stuff right is 
> 
> modprobe -c > /etc/conf.modules
> 
> the -c argument causes modprobe to print a complete conf.modules (less
> any
> strange stuff specific to your machine), so I just redirect it to the
> file. The installer should do this, though...

Why should it? (when it isn't necessary). The -c switch tells 
modprobe to list its compiled-in configuration, so there 
is no point in dumping it all to the config file. Adding
the aliases for the ppp-compress options is all that is 
needed.

Barrie


--
Barrie Spence			Sanity Clause? There is no Sanity Clause
Home: barrie@calvin.demon.co.uk		Telephone +44 1506 442304
Play: b.spence@computer.org		

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
