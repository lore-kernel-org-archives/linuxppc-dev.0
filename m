Date: Tue, 21 May 2002 10:03:40 -0700
From: Matt Porter <porter@cox.net>
To: "Curry, Diane" <dcurry@infiniswitch.com>
Cc: "Linuxppc Newsgroup (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405GP TLBHI "E" field
Message-ID: <20020521100340.A17617@home.com>
References: <3D296C067098F149B11A8F4FC37C054606F4E8@EXVS1.ops.infiniswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D296C067098F149B11A8F4FC37C054606F4E8@EXVS1.ops.infiniswitch.com>; from dcurry@infiniswitch.com on Tue, May 21, 2002 at 10:04:21AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 10:04:21AM -0400, Curry, Diane wrote:
>
> Hello,
>   I'm running 2.4.14pre3 on a custom ppc405GP board that has a little-endian device
> on the peripheral bus.  I've modified the finish_tlb_load code path to recognize the
> physical address of the device and set the "E" bit in the tlb entry for the page.
> The driver and device work fine using this feature, but what I did in finish_tlb_load
> is not a reasonable solution.  Is there a kernel interface callable from a driver
> that can be used to specify the endianness of a memory range, and set the "E"
> bit appropriately?  If not, are there any plans to implement this capability?

There are no plans (that I've ever heard of) to implement E bit support
because it has no value in Linux.  Use read*/write* to access your little
endian device.  PPC has lwbrx/stwbrx for a reason...use them...they are
included for free.

Regards,
--
Matt Porter
porter@cox.net

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
