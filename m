To: Dan Malek <dan@embeddededge.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx parameter RAM clashes 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Dec 2001 12:21:05 EST."
             <3C2CAA01.6040801@embeddededge.com>
Date: Wed, 28 Nov 2001 18:35:08 +0100
Message-Id: <20011128173513.92695F9BB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C2CAA01.6040801@embeddededge.com> you wrote:
>
> > it would be nice if the drivers would  register  the  locations  they
> > use,  and  actually  CHECK for collisions, instead of silently let us
> > run into strange and often hard to debug error conditions.
>
> So, add it then.

Does that mean that such a patch would be accepted?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have often regretted my speech, never my silence.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
