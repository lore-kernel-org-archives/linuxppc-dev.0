Message-ID: <21A8AE56EBB6D411A4520060973D360101A9F738@PEPINTERCOM>
From: Claus Gindhart <Claus.Gindhart@kontron.com>
To: James Don <JDon@spacebridge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: RPM: how do i un-pack an rpm without installing ...
Date: Tue, 14 Jan 2003 08:32:18 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C2BB9F.111AD300"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C2BB9F.111AD300
Content-Type: text/plain

Or just use the attached script
(it is also based on rpm2cpio)

--
Mit freundlichen Gru?en / Best regards

Claus Gindhart
Software Design Engineer

PEP Modular Computers GmbH     phone:    +49-8341-803-374
R&D Software                   fax:      +49-8341-803-40-374
Sudetenstrasse 7               email:    claus.gindhart@kontron.com
D-87600 Kaufbeuren             web page: http://www.pep.de
                                         http://www.kontron.com


-----Original Message-----
From: Mark Hatle [mailto:fray@mvista.com]
Sent: Dienstag, 14. Januar 2003 02:19
To: James Don
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPM: how do i un-pack an rpm without installing ...



James Don wrote:
> Sorry,
> Not really a topic for this group but ...
>
> how do i un-pack an rpm without installing it?

Use "rpm2cpio" to produce a cpio archive, and then use cpio to extract it.

"rpm2cpio <rpm> | cpio -id" works for me.

--Mark




------_=_NextPart_000_01C2BB9F.111AD300
Content-Type: application/octet-stream;
	name="unpack_rpm"
Content-Disposition: attachment;
	filename="unpack_rpm"

#!/bin/sh
# The purpose of this shell script is to unpack a
# source RPM package to the current directory
rpm2cpio $1 | cpio --extract --make-directories


------_=_NextPart_000_01C2BB9F.111AD300--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
