Message-ID: <3CB5BC71.AABD12C7@esteem.com>
Date: Thu, 11 Apr 2002 09:40:17 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Ken Applebaum <applebaumk@embeddedplanet.com>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel size
References: <D73A25AA6E54D511AD74009027B1110F237353@ORION>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ken Applebaum wrote:
>
> I know that this list is usually reserved for discussions of bringing up
> kernels, but I have a question on kernel size.
>
> What is the smallest size of kernel (including tcp/ip) that people have been
> able to build? Do the folks on this list see the large size as an issue to
> further adoption of linux on the PowerQuicc processors?
>
> Ken
>

	It all depends on what size you are refering to. Is it the size
of the compressed zImage, the compressed bzImage , the uncompressed
image, or the runtime RAM usage?

	Our zImage is just about 400,000 bytes. Our uncompressed image
is about 1 MB. The others sizes I haven't looked at. Our kernel could
be smaller if we left out fpu emulation and other modules.

	I see this as an issue that is becoming less and less
important as RAM and flash storage technology increase in size and
drop in price.

See what Wolfgang accomplished here.
http://www.denx.de/embedded-ppc-en.html
Its about mid page under the heading "PowerPC based Web Server" .

Hope this is helpful

	Conn
--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com

Stock Ticker Symbol				ELST

"clark@esteem.com" Copyright 2000 By Electronic Systems Technology
 This email address may be used to communicate to Conn Clark
 provided it is not being used for advertisement purposes, unless
 prior written consent is given. This email address may not be
 sold under any circumstances. All other rights reserved.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
