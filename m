Message-ID: <00512BA4F9D3D311912A009027E9B8F4AC3D67@nt.sixnet.com>
From: Dave Ellis <DGE@sixnetio.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: "'LinuxPPC'" <linuxppc-embedded@lists.linuxppc.org>,
	"'Dan Malek'" <dan@embeddededge.com>
Subject: RE: Questions about ARP
Date: Tue, 12 Aug 2003 10:05:40 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

> Windows is checking for duplicate addresses using ARP packets
> with source _and_
> destination address set to the address in question. So of
> course Linux won't answer it!
>
> But I can't find a single word in the RFC2131
> (http://www.faqs.org/rfcs/rfc2131.html)
> saying that the
> Source Address _must_ set to 0.0.0.0!!!!

It is actually in RFC1541 "... The client may
   perform a check on the suggested address to ensure that the address
   is not already in use.  For example, if the client is on a network
   that supports ARP, the client may issue an ARP request for the
   suggested request.  When broadcasting an ARP request for the
   suggested address, the client must fill in its own hardware address
   as the sender's hardware address, and 0 as the sender's IP address,
   to avoid confusing ARP caches in other hosts on the same subnet."

Dave

Dave Ellis
~~~~~~~~~~~~~~~~~~~~~~~~~~
SIXNET - "Leading the Industrial Ethernet Revolution"
331 Ushers Road,   P.O. Box 767, Clifton Park, NY 12065 USA
Tel +1 (518) 877-5173   Fax +1 (518) 877-8346
Email me at: dge@sixnetio.com
Detailed product info: www.sixnetio.com
~~~~~~~~~~~~~~~~~~~~~~~~~~


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
