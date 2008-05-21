Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 4AE47DE313
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 05:53:07 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1693739ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 12:53:01 -0700 (PDT)
Message-ID: <fa686aa40805211253l173cd68v77f40cf70ff6b949@mail.gmail.com>
Date: Wed, 21 May 2008 13:53:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <Pine.LNX.4.64.0805212115310.5386@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211754300.5386@axis700.grange>
	<20080521161039.GA9050@polina.dev.rtsoft.ru>
	<Pine.LNX.4.64.0805211820460.5386@axis700.grange>
	<20080521164841.GA17813@polina.dev.rtsoft.ru>
	<fa686aa40805211005h58ea66dfl792eae460d4ea3d@mail.gmail.com>
	<Pine.LNX.4.64.0805211940060.5386@axis700.grange>
	<fa686aa40805211206g5f23d3dax3e33c5aebe7aa4f1@mail.gmail.com>
	<Pine.LNX.4.64.0805212115310.5386@axis700.grange>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 1:20 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 21 May 2008, Grant Likely wrote:
>
>> If some behaviour is entirely board specific and doesn't have any
>> possibility of being duplicated on other boards, then it makes sense
>> for the code implementing that behaviour to live with the platform
>> code.
>
> Exactly - "entirely board specific" and "doesn't have any possibility of
> being duplicated on other boards."
>
>> > What good is an OF-binding if it doesn't provide complete information?
>>
>> It still increases the amount of common code even if there are rare
>> corner cases that require board specific code.
>
> Right again - _rare_ corner cases. Whereas we are talking about _all_ SPI
> busses, maybe apart from those, where the controller itself switches CSs
> in a well-defined way, and the driver doesn't need any additional
> information to handle this.

Ah, I see where we are crossing our wires.  I was talking about the
case of registering spi devices.  I agree that the spi bus should not
need any additional information.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
