Message-ID: <40486600.9090304@jonmasters.org>
Date: Fri, 05 Mar 2004 11:35:28 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: uncached user space mapping with mmap() ???
References: <40473464.8010203@imc-berlin.de> <404837D3.3060609@imc-berlin.de>
In-Reply-To: <404837D3.3060609@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Steven Scholz wrote:

| Is it always better to map only the small part I am going to use?

Of course it is always best to map only the small range that you are
going to use and there will not necessarily be only one TLB mapping (I
am here referring to your comments on ARM Linux Kernel List) etc. etc.
However here especially I am inclined to repeat what they said on the
other list - these figures are so close that they might differ for other
reasons and so on. Did you repeat this in a controlled way many times?

You will need to answer the questions Russell King posted in order for
us to work through this and figure out where the difference lies.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
