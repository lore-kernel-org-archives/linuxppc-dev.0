Date: Wed, 21 May 2003 09:43:40 -0700
Subject: Re: Virtex II Pro eval Boards
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-embedded@lists.linuxppc.org
To: Peter Ryser <Peter.Ryser@xilinx.com>
From: bob piatek <bobtek@fishcamp.com>
In-Reply-To: <3ECBA414.64549ECD@xilinx.com>
Message-Id: <60AF3064-8BAB-11D7-B3D5-000393D6CBAE@fishcamp.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter,

The documentation I was referring to is the opb_pci_designspec.pdf
(DS437 V2.1 January 7, 2003) from the latest EDK.  Although it
documents host bridge operation, on page 2 it states that host bridge
functionality is not implemented but will be available in a future
release of the core.

Bob

fishcamp engineering
105 W. Clark Ave.
Orcutt, CA  93455

http://www.fishcamp.com
TEL: 805-937-6365
FAX: 805-937-6252



On Wednesday, May 21, 2003, at 09:06 AM, Peter Ryser wrote:

>
> Bob,
>
> V2PDK contains all necessary files for a PCI host configuration and the
> example design for ML300 uses it. The design as well as the PCI host
> bridge are documented in V2PDK.
>
> - Peter
>
>
> bob piatek wrote:
>
>> Glad to hear that the OPB-PCI bridge supports host configurations!
>>
>> The documentation needs updating.
>>
>> Bob
>>
>> fishcamp engineering
>> 105 W. Clark Ave.
>> Orcutt, CA  93455
>>
>> http://www.fishcamp.com
>> TEL: 805-937-6365
>> FAX: 805-937-6252
>>
>> On Friday, May 16, 2003, at 05:22 PM, Peter Ryser wrote:
>>
>>>
>>>> Xilinx has a OPB to PCI bridge that supports their PCI core but it
>>>> doesn't (yet) support host applications.
>>>
>>> Yes, it does. Many PCI, PCMCIA, and PC cards work.
>>>
>>> - Peter
>>>
>>>
>>>
>>>
>>>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
