Message-ID: <1618.80.7.99.14.1087489756.squirrel@www.solinno.co.uk>
In-Reply-To: <20040617161616.GK24479@smtp.west.cox.net>
References: <1831.80.7.99.14.1086886556.squirrel@www.solinno.co.uk>
    <20040617161616.GK24479@smtp.west.cox.net>
Date: Thu, 17 Jun 2004 17:29:16 +0100 (BST)
Subject: Re: [RFC][PATCH 3/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini said:
> On Thu, Jun 10, 2004 at 05:55:56PM +0100, Leigh Brown wrote:
>
>>
>> This patch adds a function residual_pcidev_irq() which finds out
>> from the residual data which IRQ the given PCI device should use.
>> The interesting part about this patch is the changes I made to
>> prep_pcibios_fixup().  The old code was more than a little
>> opaque so I tried to change it to make it a bit clearer.  I'd
>> definitely be pleased if someone could cast their eyes over
>> that bit.
>
> Is this jsut a "Residual Data is Good" type change, or does it fix some
> set of IBM machines?  I ask since residual data on Motorola PRePs can be
> incorrect, iirc.

The idea is that we can support machines we don't know about, assuming
their residual data is correct.  IMO it is better to use the residual
data where possible, then add code for those machines that have broken
residual data.

In my experience, the only IBM PReP machines I know that have broken
residual data are the 6020 and 6030 laptops.  I'm planning on adding
code to work around their brokeness when I get a chance.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
