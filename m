Mime-Version: 1.0
Message-Id: <a04310105b8e0d35b581e@[199.170.89.81]>
In-Reply-To: <20020415075754.31208@mailhost.mipsys.com>
References: <a04310101b8e0b0f04111@[199.170.89.178]>
 <20020415075754.31208@mailhost.mipsys.com>
Date: Mon, 15 Apr 2002 14:01:32 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Jeff Walther <trag@io.com>
Subject: Re: PPB Bug in PowerSurge:  was: 9600 maturity
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:57 +0100 04/15/2002, benh@kernel.crashing.org wrote:

>>Do you have suggestions on where I might begin a hunt for such an OF
>>patch?  I assume this is something that one could load in NVRAM under
>>any OS that will take care of the bug until the next time the NVRAM
>>is reset?
>
>Yes. DTS provides one for some machines (for example the 6400) if you
>ask. Some PCI card vendors with a pci<->pci bridge on their card need
>it.

I suspect I'm going to feel silly for needing to ask this, but how do
I contact DTS and what does it stand for?

I was aware that there was a patch for the 6400.   Does that same
patch solve the multi-level PPB problem in PowerSurge as well?

Thank you again.  I'm ecstatic to have received this info from you.
I wasn't expecting to ever get any info on this issue.  Most people
don't seem to know about it, or aren't willing to discuss it, maybe.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
