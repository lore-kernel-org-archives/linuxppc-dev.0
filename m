Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC0605E@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Mark Hatle'" <fray@mvista.com>,
	James Don <JDon@spacebridge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: RPM: how do i un-pack an rpm without installing ...
Date: Tue, 14 Jan 2003 09:54:51 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you all ...

-----Original Message-----
From: Mark Hatle [mailto:fray@mvista.com]
Sent: Monday, January 13, 2003 8:19 PM
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


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
