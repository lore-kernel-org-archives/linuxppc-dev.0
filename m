Message-ID: <3D9AA452.5070004@elsoft.ch>
Date: Wed, 02 Oct 2002 09:46:26 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
References: <OF8DC4E66D.5C36B7D3-ON87256C41.00434ACB@boulder.ibm.com> <20020930040143.GF10265@zax> <20021001052121.GV10265@zax> <3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> On Tue, Oct 01, 2002 at 10:37:20AM +0200, "David M?ller (ELSOFT AG)" wrote:
>
[stuff deleted]
>>
>>In your proposed patch, i'm missing a way to install a board specify
>>mapping either by using special constants, callback functions to board
>>specific code, .... AFAICS all boards are forced to use the same mapping.
>
>
> That's right.  Is there a reason for boards to have different
> mappings?  I can well believe that there is, but the current tree
> doesn't show it - all the boards (in the tree) that have PCI appear to
> do the same initialisation of the windows.  It doesn't seem worthwhile
> to create board specific PCI initialisation hooks until we have a
> board that needs it.
>

Not all boards using LinuxPPC are in the offical tree (yet). I know at
least two boards which are using a "non-standard" PCI mapping.

Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
