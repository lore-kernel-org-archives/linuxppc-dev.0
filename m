Message-ID: <3E23657D.7090302@mvista.com>
Date: Mon, 13 Jan 2003 19:18:53 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: James Don <JDon@spacebridge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPM: how do i un-pack an rpm without installing ...
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC0605A@SNCMAIL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James Don wrote:
> Sorry,
> Not really a topic for this group but ...
>
> how do i un-pack an rpm without installing it?

Use "rpm2cpio" to produce a cpio archive, and then use cpio to extract it.

"rpm2cpio <rpm> | cpio -id" works for me.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
