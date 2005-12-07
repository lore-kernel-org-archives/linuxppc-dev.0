Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9E293688BF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 09:53:27 +1100 (EST)
To: Frank Bennett <bennett78@digis.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 07 Dec 2005 14:23:10 MST."
	<439752BE.9030207@digis.net>
Date: Wed, 07 Dec 2005 23:53:24 +0100
Sender: wd@denx.de
Message-Id: <20051207225324.63BED352597@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Video Card to Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <439752BE.9030207@digis.net> you wrote:
>
> The denx.de web site looks great.

Thanks :-)

> Where can someone get this PCI card?  Do I have to contact Fujitsu 
> directly? Cost?

I guess you have to contact Fujitsu directly; we worked with  Fujitsu
Microelectronics Europe.

> The Fujitsu CoralP evaluation board MB86295EB01? or did you use the 

Yes.

> Coral PA?

No.

> I saw a posting that you also had some streaming video running.  Tell me 
> more.

See ftp://ftp.denx.de/pub/fujitsu/Coral-P/README.html

> What resolution? 4CIF (full DVD)
> What display?  LCD SVGA (800x600) and/or VGA analog port?

We used a 1024 x 768 LCD.

> Software MPEG decoder or does the Coral  have a decoder?

There was no decoder involved at all. The  CoralP  can  stream  video
directly,  without  any CPU load :-) We used the "zvideo" application
for demos - see above.

> Which player did you use?

None. Just a video source like a standard DVD player or a camera.

> Is all this covered in some release notes?

See the README.html

> Was the katix stuff ever integrated into linux_2_4_development?

Yes, it was. See the drivers/spi/ diretory in our  linuxppc_2_4_devel
tree, or
http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git;a=tree;h=464f005880de29947ee7d2d8941446c4ba76b0f8;hb=95300e1ab7d8a330784a882db868e355af6d638a;f=drivers/spi

> How does Wolfgang make a living if he spends all his time answering our 
> questions?

Dunno. Next question, please :-)


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Bradley's Bromide: If computers get too  powerful,  we  can  organize
them into a committee - that will do them in.
