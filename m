Mime-Version: 1.0 (Apple Message framework v609)
In-Reply-To: <20040110003731.GD23038@krispykreme>
References: <00c801c3d6d6$a9f818a0$7138e30a@ibm18437> <20040110003731.GD23038@krispykreme>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <367D9728-436D-11D8-A844-000393911DE2@sara.nl>
From: Remco Post <r.post@sara.nl>
Subject: Re: Linux on IBM 9076 nodes
Date: Sat, 10 Jan 2004 14:02:15 +0100
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 10, 2004, at 01:37, Anton Blanchard wrote:

>
> Hi,
>
>> Our lab has recently acquired a 48-node IBM SP configuration based on
>> 4-way "Winterhawk-II" Power3-2 wide nodes with 8 GB memory. I see on
>> the
>> Linuxppc site (boxes) that Linux is known to work on 9076-SP nodes
>> (ours). How difficult is the port? IBM does not support Linux on the
>> 9076 but does on the newer Power4 pSeries units.
>
> We've booted linux on winterhawks in the past, there was one weird
> problem where we allocated memory for RTAS too high but that should be
> fixed.
>
> As pointed out we have no support for the switch unfortunately.
>
> One of our build machines here is a nighthawk (16 way 9076) and it
> works
> nicely in case anyone has a cluster of these lying around :)
>

unfortunately, IBM wanted ours back when it was traded in for 6 32way
p690's.... we had 8 16cpu nodes ;-)

> Anton
>
>
>
--
Met vriendelijke groeten,

Remco Post

SARA - Reken- en Netwerkdiensten                      http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the
computer industry. Not that that tells us very much of course - the
computer industry didn't even foresee that the century was going
to end."                                       -- Douglas Adams


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
