Message-ID: <3DAB2EE8.2040900@mvista.com>
Date: Mon, 14 Oct 2002 15:54:00 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Binary Compatibility of various flavors of PPC
References: <20021014204900.BD7B3FAA5@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <3DAB2923.3060607@mvista.com> Mark Hatle wrote:
>
>>IMHO it is a bad practice to mix and match userspace between 403/8xx, 405, and
>>7xx/74xx/82xx series of processors.  It is just asking for problems..  but it
>>definatly can be done given proper resources and understanding of the underlying
>>problems.
>
>
> A lot of things _can_ be done. But do all these things make sense
> (technically and commercially)?

Hehe if ya want to pay me a million dollars (or more) I'll be happy to make it
work.. ;)  But I still won't recommend it to anyone.  The answer to this is
understand what you are getting yourself into and understand that you are
probably costing yourself much more over the short and long term to use a
"common" set of binaries then to use binaries tailored for the specific CPU that
you are using.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
