Message-ID: <3CFEF5FC.6050301@embeddededge.com>
Date: Thu, 06 Jun 2002 01:41:16 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 8260 Network Performance update
References: <NCBBIINEHIPFGJPLBEIFOEDMDIAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis wrote:

> Does this help to identify the problem and a possible solution? Additional
> tests recommendations?

If you are writing a custom application, don't forget that you can set
several socket options (the most popular are the buffer sizes) that will
have an effect on the link performance if you know something about the
link parameters.  You could try increasing the number of receive buffers
in the Ethernet driver, and I guess we should modify the driver to DMA
directly into skbufs.  I would be surprised if either of these last two
would increase the performance, but I've been surprised by a few things lately :-).


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
