Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZs044krlzF0t6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 02:27:11 +1100 (AEDT)
Subject: Re: PA Semi PWRficient Gigabit Ethernet doesn't work anymore since
 the first networking updates for the kernel 4.16
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <DB3PR0402MB38492999533EB4400DED45BFECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516348851.4730.15.camel@infinera.com> <20180119132251.GJ32299@lunn.ch>
 <9e8e906d-b2b7-f11c-30ed-ccdf91ac563c@xenosoft.de>
 <20180204171626.GE10544@lunn.ch>
 <93dcb6c1-75d5-539c-c867-09266d43dbd0@xenosoft.de>
 <20180205142901.GD11811@lunn.ch>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <00fa4f4c-4471-f3d5-5a0d-89696a3d23c3@xenosoft.de>
Date: Mon, 5 Feb 2018 16:27:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180205142901.GD11811@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, you can.

Christian

On 05 February 2018 at 3:29PM, Andrew Lunn wrote:
> On Mon, Feb 05, 2018 at 10:38:34AM +0100, Christian Zigotzky wrote:
>> Hello Andrew,
>>
>> Many thanks for your patch. I compiled the latest git kernel today and the
>> PA Semi PWRficient Gigabit Ethernet works with your patch.
> Great.
>
> Can i add a tested-by:
>
> Thanks
> 	Andrew
>
