Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Elan Feingold" <elan@nxnetworks.com>
To: <wd@denx.de>, <kenneth.johansson@inn.ericsson.se>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Driver question 
Date: Mon, 27 Aug 2001 13:25:58 -0500
Message-ID: <NDBBLJLFCLLGDHJPGKGCCECFEEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <20010826204606.0BC8A10CBE@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > One of them lives at 0x84000800 (above 2Gb!).
> That's a physical address, right?

Correct.

> Ummm... you must have been doing something wrong.

Yep, I wasn't page aligning the 0x8400800 8-)  That did it.

> You can use mmap(), but of course  you  need  a  device  driver  that
> provides such a mmap() interface.

It didn't sound like Kenneth was using a device driver (is that correct,
Kenneth?).  Is the driver used to provide additional features (like making
sure the memory is not cached, etc.)?

I'm confused 8-)  Thanks in advance for any help you can provide.

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
