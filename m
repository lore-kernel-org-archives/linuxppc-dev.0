Message-ID: <3C7AAAF5.4020802@embeddededge.com>
Date: Mon, 25 Feb 2002 16:21:57 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Rod Boyce <rod_boyce@DMCWave.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	"'dmalek@jlc.net'" <dmalek@jlc.net>
Subject: Re: mutli cast is not enabled in fec.c
References: <8D7C5F56B409554D9D46AC22195807F30616F0@exchwenz01.smtp.dmcwave.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rod Boyce wrote:

> We are using Linux kernel 2.2.14 downloaded from Wolfgang's ftp web site.  I
> believe that the kernel originally came from the Hard Hat distribution.

The code was originally written by me, long before MontaVista existed.

The multicast was not done because as you can see I stole the code from
the SCC driver and the FEC doesn't have the same function as CPM devices.
There has recently been a post on this mailing list that includes a patch
for a software CRC to implement this feature.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
