Message-Id: <4.2.2.20000120195050.00c796f0@mail.munich.netsurf.de>
Date: Thu, 20 Jan 2000 19:52:22 +0100
To: David Edelsohn <dje@watson.ibm.com>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Cc: khendricks@ivey.uwo.ca, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200001201826.NAA25092@mal-ach.watson.ibm.com>
References: <Message from Kevin Hendricks <khendricks@ivey.uwo.ca>
 <00012013133502.00819@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 19:26 20.01.00 , David Edelsohn wrote:

>         The "b" constraint should be associated with "base_addr", not with
>"regindex":
>
>         asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex),
> "b"(base_addr));

Uhm, David, that's wrong. "b" has to be assigned to %1!

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
