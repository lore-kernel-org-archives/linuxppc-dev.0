Message-ID: <3CB5DE9A.9070802@bluewin.ch>
Date: Thu, 11 Apr 2002 21:06:02 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	Christian Pellegrin <chri@infis.univ.trieste.it>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
References: <Pine.LNX.4.44.0204110914100.18980-100000@sole.infis.univ.trieste.it> <3CB539DF.CF3BDD85@imc-berlin.de> <20020411153136.GE15663@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 04/11/2002 05:31 PM, Tom Rini wrote:

>On Thu, Apr 11, 2002 at 09:23:11AM +0200, Steven Scholz wrote:
>>
>> Christian Pellegrin wrote:
>>
>> > not really sure this will help you, but I had similar problem (spurious
>> > hangs during boot/insmod on 823 and 850 MPCs). The ppc mm for 8xx in 2.4
>> > repository is broken, use that in 2.4-devel that works fine. AFA net
>> > devices are concerned check that rx start is done in open and not in init
>> > since linux doesn't like packets before a device is opened.
>>
>> Thanks for your reply.
>>
>> I got the kernel from the linuxppc_2_4_devel tree using
>>
>> bk export ... -rv2.4.18
>>
>> So I guess I do have a 2.4-devel. Right?
>
>No.  -rv2.4.18 got you 2.4.18 from kernel.org, no PPC changes at all.
>
You mean it's identical to linux-2.4.18.tar.gz from kernel.org?
[I'm just curious what I really get with the above command.]

Thanks,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
