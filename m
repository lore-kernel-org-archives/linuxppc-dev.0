In-Reply-To: <AD59566A9D83864F871AE2E52503064001A2AAA9@aimail.aiinet.priv>
References: <AD59566A9D83864F871AE2E52503064001A2AAA9@aimail.aiinet.priv>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0B9026DA-46BF-11D8-BD76-000393DB7C12@vivato.net>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Mark Rakes <mrakes@vivato.net>
Subject: Re: Intel Pro 82546 chipset performance
Date: Wed, 14 Jan 2004 10:25:35 -0800
To: "Dayton, Dean" <deand@aiinet.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I know the kernel e1000 driver works on ppc (at least on an 8245).


On Jan 14, 2004, at 8:00 AM, Dayton, Dean wrote:
> Is there a PPC compatible driver available for this the 82546 Intel Pro
> 1000. I was just handed an SBE lanPMC card with this chipset on it
> yesterday. I am trying to use it on an 8265 based system with a 2.4.21
> kernel. The driver in this kernel crashes on startup. A quick look at
> the
> driver makes me think that it has never been used on anything but x86.
> Am I
> misreading the situation? Is there an enhanced driver available?
>
> Thanks
> Dean Dayton
>
>> -----Original Message-----
>> From: Samuel Agarwal [mailto:sagarwal10@hotmail.com]
>> Sent: Wednesday, January 14, 2004 1:37 AM
>> To: linux-mips@linux-mips.org; linuxppc-embedded@lists.linuxppc.org
>> Subject: Intel Pro 82546 chipset performance
>>
>> Hi
>>
>> We're trying to use the Intel Pro 1000 adapters with the
>> 82546 chipset for a packet switching application. Has anyone
>> investigated performance on this chipset? With minimum sized
>> ethernet frames, the maximum throughput I can get is about 1
>> million packets per second (versus a 1.4 mill for line rate
>> on a gigethernet) and it looks that performance is skewed
>> towards receiving traffic (rather than sending out).
>>
>> If anyone has any opinions or thoughts I'd appreciate them.
>> It's hard to get information out of Intel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
