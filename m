Message-Id: <v04003a01b4d174851e54@[216.81.27.12]>
In-Reply-To: <B0CAE42C9EE0D311AAAD00500422FC6302CD71@iis000.microdata.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 17 Feb 2000 04:21:39 -0600
To: Patrick Lerda <Lerda@microprocess.com>, linuxppc-dev@lists.linuxppc.org,
        "'debian-powerpc@lists.debian.org'" 	 <debian-powerpc@lists.debian.org>
From: Tony Mantler <eek@escape.ca>
Subject: Re: PowerPC in little endian mode
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:52 AM -0600 2/17/2000, Patrick Lerda wrote:
>	Most of the trouble I have on my PowerPC platform came from the fact
>that
>	Linux work in big-endian mode,

[... "please run ppc-linux in little-endian mode" ...]

>	And so be able to get all the software from linux i386 working world
>without headache.

Perhaps it's just my m68k side speaking (m68k = big endian only, for those
who don't know), but I think it's safe to say that doing anything to make
it easier for lazy mouth-breathing code-typists to write sloppy and
incorrect code is a Bad Thing[tm].

Besides that, switching ppc-linux to little-endian mode would be (to put it
mildly) a pain in the ass of galactic proportions.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
