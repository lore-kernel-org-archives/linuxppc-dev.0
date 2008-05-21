Return-Path: <glikely@secretlab.ca>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.189])
	by ozlabs.org (Postfix) with ESMTP id 74F94DE4F2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:07:19 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so629270gvf.14
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 13:07:13 -0700 (PDT)
Message-ID: <fa686aa40805211307keb43bd6n1a2cc4e7e5a2d408@mail.gmail.com>
Date: Wed, 21 May 2008 14:07:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <Pine.LNX.4.64.0805212157580.5386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
	<fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
	<Pine.LNX.4.64.0805211940060.5386@axis700.grange>
	<fa686aa40805211206g5f23d3dax3e33c5aebe7aa4f1@mail.gmail.com>
	<Pine.LNX.4.64.0805212115310.5386@axis700.grange>
	<fa686aa40805211253l173cd68v77f40cf70ff6b949@mail.gmail.com>
	<Pine.LNX.4.64.0805212157580.5386@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 2:00 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 21 May 2008, Grant Likely wrote:
>
>> On Wed, May 21, 2008 at 1:20 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> >
>> > Right again - _rare_ corner cases. Whereas we are talking about _all_ SPI
>> > busses, maybe apart from those, where the controller itself switches CSs
>> > in a well-defined way, and the driver doesn't need any additional
>> > information to handle this.
>>
>> Ah, I see where we are crossing our wires.  I was talking about the
>> case of registering spi devices.  I agree that the spi bus should not
>> need any additional information.
>
> No, sorry for not making it clear. I wrote "busses" because on those
> controllers, that control CS themselves _devices_ don't need any
> additional info. But I meant, that describing SPI _devices_ should be done
> in only one way or another - either using fdt, or platform data, not both.

Yes, I agree with that too... with the one caveat that platform code
should have some method to supplement the data in the device tree
*only when it is absolutely necessary to do so*.  (note: I say
'platform code' here, not 'platform data'.  They are two different
things)  I make no claims on what that method should be at this time.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
