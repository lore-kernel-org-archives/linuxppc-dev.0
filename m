Return-Path: <kishon@ti.com>
Message-ID: <50F93813.4010107@ti.com>
Date: Fri, 18 Jan 2013 17:24:59 +0530
From: kishon <kishon@ti.com>
MIME-Version: 1.0
To: <balbi@ti.com>
Subject: Re: [RFC PATCH 0/6] USB: Add multiple PHYs of same type
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <20130118114859.GC4379@arwen.pp.htv.fi>
In-Reply-To: <20130118114859.GC4379@arwen.pp.htv.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-doc@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk,
 linux-sh@vger.kernel.org, alexander.shishkin@linux.intel.com,
 stern@rowland.harvard.edu, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, rob.herring@calxeda.com, horms@verge.net.au,
 haojian.zhuang@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, b-cousson@ti.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, cbou@mail.ru, rob@landley.net,
 dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 18 January 2013 05:18 PM, Felipe Balbi wrote:
> On Wed, Jan 16, 2013 at 08:30:56PM +0530, Kishon Vijay Abraham I wrote:
>> New platforms are being added which has multiple PHY's (of same type) and
>> which has multiple USB controllers. The binding information has to be
>> present in the PHY library (otg.c) in order for it to return the
>> appropriate PHY whenever the USB controller request for the PHY. So
>> added a new API to pass the binding information. This API should be
>> called by platform specific initialization code.
>>
>> So the binding should be done something like
>> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying the USB
>> controller device name, index, and the PHY device name.
>> I have done this binding for OMAP platforms, but it should be done for
>> all the platforms.
>>
>> After this design, the phy can be got by passing the USB controller device
>> pointer and the index.
>>
>> Developed this patch series on
>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
>> after applying "usb: musb: add driver for control module" patch series.
>>
>> Did basic enumeration testing in omap4 panda, omap4 sdp and omap3 beagle.
>
> please resend without RFC so I can apply.

I'll resend after addressing Roger's comments in a while.

Thanks
Kishon
