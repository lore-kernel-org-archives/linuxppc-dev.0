Date: Tue, 12 Aug 2003 16:22:21 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: Ricardo Scop <scop@plugin.com.br>
Message-ID: <16682.030812@plugin.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re[2]: Questions about ARP
In-reply-To: <00512BA4F9D3D311912A009027E9B8F4AC3D67@nt.sixnet.com>
References: <00512BA4F9D3D311912A009027E9B8F4AC3D67@nt.sixnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It is _also_ in RFC2131:

"The client SHOULD perform a
check on the suggested address to ensure that the address is not
already in use.  For example, if the client is on a network that
supports ARP, the client may issue an ARP request for the suggested
request.  When broadcasting an ARP request for the suggested address,
the client must fill in its own hardware address as the sender's
hardware address, and 0 as the sender's IP address, to avoid
confusing ARP caches in other hosts on the same subnet."

-Scop.

Tuesday, August 12, 2003, 11:05:40 AM, you wrote:


DE> Steven Scholz wrote:

>> Windows is checking for duplicate addresses using ARP packets
>> with source _and_
>> destination address set to the address in question. So of
>> course Linux won't answer it!
>>
>> But I can't find a single word in the RFC2131
>> (http://www.faqs.org/rfcs/rfc2131.html)
>> saying that the
>> Source Address _must_ set to 0.0.0.0!!!!

DE> It is actually in RFC1541 "... The client may
DE>    perform a check on the suggested address to ensure that the address
DE>    is not already in use.  For example, if the client is on a network
DE>    that supports ARP, the client may issue an ARP request for the
DE>    suggested request.  When broadcasting an ARP request for the
DE>    suggested address, the client must fill in its own hardware address
DE>    as the sender's hardware address, and 0 as the sender's IP address,
DE>    to avoid confusing ARP caches in other hosts on the same subnet."

[]'s, Scop                            mailto:scop@digitel.com.br

--------------------------------------------------------------------
"Ninety-eight percent of the adults in this country are decent,
hard-working, honest citizens. It's the other lousy two percent that
get all the publicity. But then -- we elected them."  ~Lily Tomlin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
