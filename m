Message-ID: <3F390A32.5040507@embeddededge.com>
Date: Tue, 12 Aug 2003 11:39:30 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Brad Parker <brad@parker.boston.ma.us>
Subject: Re: Questions about ARP
References: <3F33BC10.8060407@imc-berlin.de> <3F33EADE.4010908@embeddededge.com> <3F38DEC4.8050708@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> Windows is checking for duplicate addresses using ARP packets with
> source _and_
> destination address set to the address in question. So of course Linux
> won't answer it!
>
> But I can't find a single word in the RFC2131
> (http://www.faqs.org/rfcs/rfc2131.html)
> saying that the Source Address _must_ set to 0.0.0.0!!!!

I don't remember if it was in RFC2131 or RFC1541.  RFC2131 is an updated
version of RFC1541, so I thought the words would still be there.  In
any case it suggests as part of a DHCP the client tests to ensure the
address isn't already in use by sending a ARP using the sender hardware
address and setting the sender IP address to zero to avoid confusing
ARP caches in other hosts on the network.  I don't remember the exact
words, but RFCs tend to be terse and concise in the area where you
need to pay attention to detail :-)

I'd suggest using the linux kernel or some networking mailing lists
to discuss this.  I wouldn't apply this patch because it seems to be
wrong in the eyes of the RFCs, and I could never get it pushed into
the network portion of the source tree.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
