To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: "'Sam Ravnborg'" <sam@ravnborg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Failsafe bootloader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Jun 2003 08:15:08 CDT."
             <F9102D41F595D311ACA7009027DE2C840527B347@c3po.heurikon.com>
Date: Wed, 04 Jun 2003 16:11:39 +0200
Message-Id: <20030604141144.6787CC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <F9102D41F595D311ACA7009027DE2C840527B347@c3po.heurikon.com> you wrote:
>
> We implemented a verification feature to ppcboot for products that performs
> a crc32 check before branching to an image. If the crc32 fails to match a
> stored checksum, it will check a secondary image, if that one fails too then
> we usually default to a tftp from a well known tftp server that we have
> accessible. One could take this to as much extreme as desired, but that's up
> to the system designers to deem what's reasonable and what's overkill. The
> key is the primitives to do such are in place.

What exactly did you "implement" for this?

All this is already in place with the standard PPCBoot / U-Boot.  And
has been there right from the first versions.

> ppcboot allows this to be quite easy since the bootcmd can contain several
> commands.

Right, this allows for simple applications like you described above.

More complex things are possible by enabling the hush shell.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
News is what a chap who doesn't care much  about  anything  wants  to
read. And it's only news until he's read it. After that it's dead.
                           - Evelyn Waugh _Scoop_ (1938) bk. 1, ch. 5

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
