Message-ID: <3C867302.7080202@embeddededge.com>
Date: Wed, 06 Mar 2002 14:50:26 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: laurent.pinchart@capflow.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <20020306170947.078ED109EB@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> There are no differences AFAIK. It's just a faster CPU that allows 66
> or even 76 MHz with 1:1 CPU/bus clock mode.

Interesting.  Faster than 50 MHz cores used to require the 2:1 bus
clock division.  I don't remember timing parameters that would
exceed 50 MHz.  Yes, the part will let you do that, but I thought that
was outside of the part specification.  I guess I'll have to take a look.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
