Message-ID: <3F4CE8BF.1090003@mvista.com>
Date: Wed, 27 Aug 2003 10:22:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: ghannon@cspi.com
Cc: ??? <ksshin@essetel.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: interrupt handling in 7410+64260
References: <85256D8F.004ABAE9.00@pine.cspi.com>
In-Reply-To: <85256D8F.004ABAE9.00@pine.cspi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ghannon@cspi.com wrote:

>>2. request_irq(77, ...)
>>   77 means bit 15 of GPP_INTERRUPT_CAUSE register.
>>
>>
>
>There is an offset of 64, try 79 vs 77 to get bit 15.
>
>
Yep, 79 sounds right, if its GPP 15.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
