Return-Path: <per.friden@stericsson.com>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87101B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 17:36:45 +1000 (EST)
Message-ID: <4CA1959F.8050806@stericsson.com>
Date: Tue, 28 Sep 2010 09:13:35 +0200
From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.friden@stericsson.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFCv2 1/2] dmaengine: add support for scatterlist to
	scatterlist transfers
References: <1285370032-16937-1-git-send-email-iws@ovro.caltech.edu>
	<1285370032-16937-2-git-send-email-iws@ovro.caltech.edu>
	<AANLkTimzdEhAZ=oXbbB3Ge5=YY7OXq3fjaRH4roPNB-k@mail.gmail.com>
	<20100927172356.GA805@ovro.caltech.edu>
In-Reply-To: <20100927172356.GA805@ovro.caltech.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linus Walleij <linus.ml.walleij@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mon, Sep 27, 2010 at 05:23:34PM +0200, Linus Walleij wrote:
>> 2010/9/25 Ira W. Snyder <iws@ovro.caltech.edu>:
>>
>>> This adds support for scatterlist to scatterlist DMA transfers.
>>
>> This is a good idea, we have a local function to do this in DMA40 already,
>> stedma40_memcpy_sg().
>>
> 
> I think that having two devices that want to implement this
> functionality as part of the DMAEngine API is a good argument for making
> it available as part of the core API. I think it would be good to add
> this to struct dma_device, and add a capability (DMA_SG?) for it as
> well.
> 
> I have looked at the stedma40_memcpy_sg() function, and I think we would
> want to extend it slightly for the generic API. Is there any good reason
> to prohibit scatterlists with different numbers of elements?
No

/Per
