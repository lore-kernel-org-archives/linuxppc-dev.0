From: Brian.Dominy@radisys.com
Subject: Re: unable to mount root fs on 01:00
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Stefan Balcerczak" <Stefan.Balcerczak@marconi.com>
Message-ID: <OF47B371D7.E5F86146-ON85256A37.00439441@radisys.com>
Date: Mon, 23 Apr 2001 08:21:16 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan,

Check to make sure you have loopback driver support compiled into your
kernel.  You'll need that in order to mount a ramdisk.

Regards,
Brian Dominy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
