Return-Path: <mware@elphinstone.net>
Received: from ipmail04.adl2.internode.on.net (ipmail04.adl2.internode.on.net
	[203.16.214.57]) by ozlabs.org (Postfix) with ESMTP id A0F21DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 14:28:53 +1000 (EST)
Message-ID: <4A07A982.40504@elphinstone.net>
Date: Mon, 11 May 2009 14:28:50 +1000
From: Mark Ware <mware@elphinstone.net>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than	NULL
References: <49EDC0BE.7040505@elphinstone.net>
	<E2205842-8019-4CE4-812B-64ABD76F36F4@kernel.crashing.org>
	<20090422215646.GA19997@trinity.fluff.org>
	<AAD6564F-9D99-492B-8364-10A652F990DF@kernel.crashing.org>
	<20090503222352.GB5750@fluff.org.uk>
In-Reply-To: <20090503222352.GB5750@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben Dooks wrote:
> On Wed, Apr 29, 2009 at 08:43:14AM -0500, Kumar Gala wrote:
>> On Apr 22, 2009, at 4:56 PM, Ben Dooks wrote:
>>
>>> On Tue, Apr 21, 2009 at 10:11:51AM -0500, Kumar Gala wrote:
>>>> On Apr 21, 2009, at 7:49 AM, Mark Ware wrote:
>>>>
>>>>> Recent DMA changes result in a BUG() when NULL is passed to
>>>>> dma_alloc_coherent in place of a device.
>>>>>
>>>>> Signed-off-by: Mark Ware <mware@elphinstone.net>
>>>>> ---
>>>>>
>>>>> This patch fixes the BUG() during boot that has appeared during the
>>>>> 2.6.30 window. It has been tested and appears correct on my 8280  
>>>>> based
>>>>> board.
>>>>> Sent to both linuxppc-dev and linux-i2c, since I'm not sure where it
>>>>> belongs.
>>>>>
>>>>>
>>>>> drivers/i2c/busses/i2c-cpm.c |   14 ++++++++------
>>>>> 1 files changed, 8 insertions(+), 6 deletions(-)
>>>> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>>>>
>>>> Ben, I'm expecting you to pick this up unless you tell me otherwise.
>>> Yes.
>> This go in yet?
> 
> I've had to do a manual apply due to some changes in the
> driver, so can someone please do a build of my git tree
> at:
> 
> git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630-rc5
> 
> or tell me which arch and defconfig to build.
> 

Ping.  Is there anything still blocking this?

Mark Ware
