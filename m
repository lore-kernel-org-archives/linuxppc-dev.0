Message-ID: <3BC716D2.6020902@humboldt.co.uk>
Date: Fri, 12 Oct 2001 17:14:10 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: mod+linuxppc-dev@mclx.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC+southbridge designs
References: <200110121337.JAA21171@missioncriticallinux.com> <20011012050917.A15738@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> On Fri, Oct 12, 2001 at 09:37:27AM -0400, mod+linuxppc-dev@mclx.com wrote:
>>How many existing PPC-based machines incorporate one
>>of those kitchen-sink southbridge chips like the VIA
>>VT82C686B that are normally found in x86-based machines?


> A lot of them.  Hardware developers for high-end PPC embedded designs
> like them as a way to get UARTs, PIC, and IDE in one dirt-cheap package.
> Software developers hate them because they are evil.


Once they've used them once, the hardware engineers think they're evil
as well. But I did get a 7410 system with a Via 686a up and running the
2.4-devel kernel. I think all the necessary fixes have percolated into
the main tree, except for one MIDI fix which is only in Alan Cox's kernel.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
