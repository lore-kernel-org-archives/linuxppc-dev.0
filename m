Message-ID: <407DEC4A.3080305@embeddededge.com>
Date: Wed, 14 Apr 2004 21:58:34 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Richard Laing <Richard.Laing@4rf.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Slow down with recent linux kernel
References: <4ABDB84E30B89F4E9C942C186F0B9EF605BBC6@4rf-nz-mail.local.4rf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Laing wrote:

> ....Startup time for our application form power on to running is increased
 > by between 30% and 50%.

How does your application start up?  Initrd? Jffs2? Network?
What are you actually measuring?

Use some standard, focused, benchmarks and collect some quantitative data.
Then, we can discuss something.

> ....this uses consistent_alloc which doesn't appear to return a
 > real physical address

Sure it does....dma_addr_t.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
