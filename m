Message-ID: <3D995EC0.2000500@elsoft.ch>
Date: Tue, 01 Oct 2002 10:37:20 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

David Gibson wrote:
> On Mon, Sep 30, 2002 at 02:01:43PM +1000, David Gibson wrote:
>
>>On Fri, Sep 27, 2002 at 08:27:35AM -0400, Ralph Blach wrote:
>>
>>>Yesterday I discovered a minor 405GP vs 405GPr PCI difference.
>>>IN the 405GP the ptm1ms bit 31, the enable bit for the region is set to 1
>>>by the hardware and cannot be written.
>>>On the 405GPr the bit is writable and this makes necessitates  a change in
>>>walnut.c
>>>

[stuff deleted]

>
> So, here is a patch to do that.  If there are no objections, I will
> commit this to linuxppc-2.5 BK.
>


In your proposed patch, i'm missing a way to install a board specify
mapping either by using special constants, callback functions to board
specific code, .... AFAICS all boards are forced to use the same mapping.

Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
