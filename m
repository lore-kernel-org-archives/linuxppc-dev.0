Date: Fri, 09 Nov 2001 16:23:17 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Subject: Re: linuxppc_2_4_devel on walnut
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	akuster@mvista.com
Message-id: <3BEBF4E5.B60BD9E3@inn.ericsson.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <3BDD855B.8D3FC72F@inn.ericsson.se>
 <3BE971BC.34591FF1@inn.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The saga continues.

Well some of the problems I had was of the brown paperbag over head kind of
error but now I can boot and run a version checked out a few hours ago.

But the ethernet reporting of the line is wrong. This is a problem with the
printout only as the function is right. The 100Mb full duplex is reported to
be 10Mb half and vise verse.


I have not run the walnut hardware for some time but I still have a quite
severe problem with ethernet in 10Mb.

What happens is this if I connect to a 3com 10Mb hub that is connected to the
office net (cisco switch) the switch turns off the port after some time
mostly when I run apt-get. Since the walnut card is never directly connected
to the switch this must be some logical error in packets probably the
intergap time is to small that is the only thing I can think of as the switch
only care about the ethernet layer.

This problem could maybee exist if I directly connect to the switch I have
not done that and no I can not test this easy as I don't control the switch
and now only have 1 working port in that room and it is really needed.


--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
