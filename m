Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050608092453.GA11455@iram.es>
References: <20050608092453.GA11455@iram.es>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3fc1f9541242ec650a5d1d2f188b23cd@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 8 Jun 2005 09:36:06 -0500
To: "Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [UPDATE] Getting ownership for various boards/platforms configs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel,

Agreed, but the question on the table is ownership of the current code.

- kumar

On Jun 8, 2005, at 4:24 AM, Gabriel Paubert wrote:

> On Tue, Jun 07, 2005 at 04:47:35PM -0500, Kumar Gala wrote:
>> The following boards have no owners and if they dont get one the plan
>> is to kill them:
>>
>> ep405
>> mvme5100
>> pcore
>
> Actually mvme5100 and pplus could easily be merged with generic
> PreP IIRC. At least I wrote a bootloader that remapped my
> MVME2400/2600/2700 to look like an MVME5100 (CHRP memory map
> but residual data and no OF). This allows much larger
> windows to map to the VME bus (which is often very
> sparsely populated).
>
> The only real difference at boot between MVME5100 and
> pplus is the mapping of physical addresses to PCI
> I/O and memory space, and perhaps also the way to access
> the console device. But I don't have any MVME5100 nor
> do I plan do buy one (perhaps an MVME6100 but the host
> bridge is completely different).
>
> The question is whether we want a residual data to
> pseudo OF device-tree translator in the bootloader
> or another way of passing board data to the kernel.
>
> 	Gabriel
