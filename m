To: Jeff H Zhong <jeff@doremilabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging using bdi2000, unable to proceed. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Apr 2003 15:59:33 -0000."
             <3EA020E5.6FAEBC0A@doremilabs.com>
Date: Sat, 19 Apr 2003 01:23:51 +0200
Message-Id: <20030418232356.7FC85C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EA020E5.6FAEBC0A@doremilabs.com> you wrote:
>
> I mean just like that on workstation(none embedded linux), user should
> be able to at least ping the target at the time when it brings up the
> ethernet interface, is it right?

Ummm...why? For example, U-Boot initializes the network interface and
is able to perform DHCP and TFTP downloads, but it will not reply  to
a ping as ICMP is not needed for U-Boot's purposes.

Replying to ping requests is a  non-requirement  for  most  practical
purposes, and may be blocked by any router anyway.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All these theories, diverse as they are, have two things  in  common:
they explain the observed facts, and they are completeley and utterly
wrong.                       - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
