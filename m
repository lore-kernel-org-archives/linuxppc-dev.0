Message-ID: <3D1757AD.7070305@embeddededge.com>
Date: Mon, 24 Jun 2002 13:32:29 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: navinb <ppc4@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: scc2 conflict with usb?
References: <20020624164245.25843.qmail@webmail11.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


navinb wrote:

> problem being faced is that usb (scc1 addres space) works when my
> CPM ENET is not either at SCC1 or SCC2.

How does USB conflict with SCC2 in Ethernet mode?  The default
configuration should just build this way, since the only thing
you can run on SCC1 is USB.  On an 823, the default (and about
the only configuration) is USB on SCC1, Ethernet on SCC2 and console
on SMC1.  Not all parts have SCC3.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
