To: "Pergola, Michael" <MichaelPergola@Danfoss.com>
Cc: Friedlander Paul <PaulFriedlander@Danfoss.com>,
	Hihn Jason <JasonHihn@Danfoss.com>,
	"Support (E-mail)" <techsupport@embeddedplanet.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial Port problem with 823e on Embedded Planet 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 27 Jun 2001 14:32:44 EDT."
             <E1836A7F3557D311A14000805F9F36FCD4E385@usdfo011.usac.danfoss.net>
Date: Wed, 27 Jun 2001 20:53:03 +0200
Message-Id: <20010627185308.C2F7C100B1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Michael,

in message <E1836A7F3557D311A14000805F9F36FCD4E385@usdfo011.usac.danfoss.net> you wrote:
>
> > You could switch to use SCC's instead. We have a modified driver that
> > supports full HW handshake on all SCC's (and you  can  configure  the
> > number and size of I/O buffers to optimize for throughput).
> >
> 	[Pergola, Michael]  Is that  the patch commproc.c.patch.gz dated
> 	07/20/2000?

No, this was added only lately. I did not prepare a  patch  for  this
yet. See the source tree at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-05-12.tar.bz2 ,
plus the patch at
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200106/msg00220.html

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Yes, it's a technical challenge, and  you  have  to  kind  of  admire
people  who go to the lengths of actually implementing it, but at the
same time you wonder about their IQ...
         --  Linus Torvalds in <5phda5$ml6$1@palladium.transmeta.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
