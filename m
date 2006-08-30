Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id 5A54667B6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 23:15:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Subject: RE: 2 Ethernet port operating in a PPC405EP system 
Date: Wed, 30 Aug 2006 21:17:20 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D5D@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I know my source code is vert old. But since there are lots of
applications developed base on this 2 sets of source code, if the kernel
and U-Boot needs to change, the above applications (tons of codes) also
need to revise ... (lots of multimedia players, drivers, and other
supporting tools). My team cannot afford such great change.

So I say "update is not recommended" ...=0D

Thanks for your quick reply.

Best regards,
Lo Chun Chung

-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=0D
Sent: Wednesday, 30 August, 2006 9:07 PM
To: Chun Chung Lo
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2 Ethernet port operating in a PPC405EP system=0D


In message
<A7B1E4DD46AA7046A4398F745240F29402737D5C@ASPROEXG.astri.local> you
wrote:
>=0D
> Sorry for such long e-mail.

Actually it's not so long...

> I am now working on a STB project, and our board is a IBM PPC405EP=0D
> with 2 ethernet ports. U-Boot 1.0.0 and linux 2.4.20 (from MontaVista)

> is used and update is not recommended. Each ethernet port has a=0D
> RTL8021CP PHY connected.

... as reading stops here. Both U-Boot 1.0.0 and Linux 2.4.20 are not
only old, they are ancient. Zillions of smaller and bigger bugs  have
been fixed since. Do yourself a favour and use current code.

Best regards,

Wolfgang Denk

--=0D
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.
