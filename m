Message-ID: <3D08493F.8030301@embeddededge.com>
Date: Thu, 13 Jun 2002 03:26:55 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First cut at large page support on 40x
References: <15614.63160.272890.683586@argo.ozlabs.ibm.com> <3CFF1624.2070808@embeddededge.com> <20020612035203.GQ25800@zax> <3D06E702.4000709@embeddededge.com> <20020612064344.GT25800@zax> <3D07D80F.9050306@embeddededge.com> <15623.56408.342901.245259@argo.ozlabs.ibm.com> <3D07E743.6090206@embeddededge.com> <15623.61149.22953.9238@argo.ozlabs.ibm.com> <3D081C8D.8070901@embeddededge.com> <20020613051250.GE4228@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Because any driver that relies on it working....

Just a joke, lighten up :-)  That's what thse things :-) :-) are all about.


> Huh?  First you say it isn't the drivers, then you say it is the
> drivers.

Arrgh.......actually it was a kernel problem............
IIRC, the first place I saw the problem was someone trying to build
an S/G list and we didn't look up the addresses correctly.

The bottom line is iopa() did the right thing when used on proper
lowmem addresses, and in case someone stumbled across something
we had remapped it also did the right thing.  I'm not out to be
pointing blame at drivers and I quite dislike the "don't do it
that way" response when the solution is so trivial.  We implemented
a solution (many different ways over time) to provide uncached
memory, and sometimes it didn't work right for some drivers.  This
solved the problem without me having to spend time debugging or
modifying drivers I didn't care to know anything about.  If we don't
need it anymore, then throw it away, but just make sure we don't
need it anymore.


> Err.. not me.  I ain't on any MIPS lists.  Nor do I recall writing
> anything about the eepre100 driver recently.

I didn't believe I indicated you did.  It was a comment to Paul's
statement that there is still discussion about cache line alignment
and sharing.  You can learn things from reading what some of the
other people are doing, though :-)


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
