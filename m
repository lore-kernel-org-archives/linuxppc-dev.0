Message-ID: <3F0C792A.7010901@earthlink.net>
Date: Wed, 09 Jul 2003 13:20:58 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: Wolfgang Denk <wd@denx.de>,
	Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: parallel I/O ports & opend darin pins on MPC8xx
References: <20030709195719.9BBF5C6D82@atlas.denx.de> <3F0C7782.3060704@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dean Matsen wrote:

>
> Wolfgang Denk wrote:
>
>> In message <3F0C6C0C.8040306@earthlink.net> you wrote:
>>
>>
>>>> Solution? What is so difficult about latching your output value in a
>>>> variable?
>>>>
>>>>
>>>>
>>> What he's saying is that OTHER drivers read the input and then write
>>> that value to the output.
>>>
>>>
>>
>> I did understand this.
>>
>>
>>
>>> In his driver, he can latch the output through a variable, but that
>>> won't affect what other
>>>
>>>
>>
>> Obviously all drivers that may modify bits in this I/O port will have
>> to share the variable used to latch the value.
>>
>> Yes, this may include modifying existing code in the UART or Ethernet
>> or other drivers.
>>
>>
>>
>>> Unless there is kernel support to alias the data in a memory variable
>>> (and it doesn't sound like
>>> there is), then this is going to continue to be a problem. Might I
>>>
>>>
>>
>> Don't make it unnecessary complicated. You don't need "kernel support
>> to alias the data in a memory variable". This is really not so
>> difficult to implement yourself when you need it.
>>
>>
>> Best regards,
>>
>> Wolfgang Denk
>>
>>
>>
> No no, I wasn't suggesting that it be added, I was (subtly) pointing out
> that it is not likely to be added because you'd have to review every
> other driver in the PPC system. Not gonna happen.
>
> But I still don't see how you could avoid having other drivers clobber
> your output but. I think he has to take one of the two options I
> suggested. Adding his own variable can't help in any way I can
> imagine. Could you give an example?
>
> Dean
>
>
>
>
Ooops, NM on the example -- I didn't read carefully enough. Yes,
updating the
other drivers would work too, but then he's got to maintain a ton of patches
for his version of the kernel.

Dean


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
