Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 1581367A6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 01:50:25 +1100 (EST)
To: "Edward Jubenville" <edjubenville@adelphia.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Mar 2005 06:29:19 PST."
	<GPECLCIGPLHEOMGPMCPAGEILCMAA.edjubenville@adelphia.net>
Date: Mon, 14 Mar 2005 15:50:06 +0100
Sender: wd@denx.de
Message-Id: <20050314145011.9BE56C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK 3.1 installation tells me "Wrong format of the rpm
	archive"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <GPECLCIGPLHEOMGPMCPAGEILCMAA.edjubenville@adelphia.net> you wrote:
> I tried installing ELDK 3.1 on RedHat 9,
> but all I got was this:
> 
>    Installing cross RPMs
>    Wrong format of the  rpm archive.

Did you verify the images?

> I'm a rookie, so I'm sure I screwed something up. I had downloaded
> the ISO image to my Windows PC, made the CD there, copied the tree
> onto my Linux box at /ELDKCD, then tried:
> 
> 	./install -d /ELDK
> and
> 	./install -d /ELDK ppc_6xx
> 
> What did I do wrong?

I can only speculate: probablky your doenload was  not  performed  in
binary mode, and/or the image got corrupted. 

Pleas make sure to verify the MD5 checksum of thr ISO image  (or  the
MD5  checksums  of the file son the CD). RH 9 is one of the platforms
which are officially supported and tested.

[BTW: you may want to switch to ELDK 3.1.1 anyway :-) ]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A dog always bit deepest on the veterinary hand.
                                    - Terry Pratchett, _Wyrd Sisters_
