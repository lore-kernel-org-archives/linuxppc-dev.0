Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A451DE4F4
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 04:11:12 +1100 (EST)
Message-ID: <48F4D29F.6090909@selcomgroup.com>
Date: Tue, 14 Oct 2008 19:10:55 +0200
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
References: <1223997906-19900-1-git-send-email-agust@denx.de>	<gd2f4s$82f$1@ger.gmane.org>
	<20081014170455.GA16338@oksana.dev.rtsoft.ru>
In-Reply-To: <20081014170455.GA16338@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Carminefb driver, though, supports 800x600 resolution.

BTW, I tried this patch and I get wrong colors on a patched DirectFB 
which is changing the endianness on the fly. Is this driver already 
taking care of this?

Regards,
M

Anton Vorontsov ha scritto:
> On Tue, Oct 14, 2008 at 03:50:52PM +0000, Dmitry Baryshkov wrote:
>   
>> Anatolij Gustschin wrote:
>>
>>     
>>> This patch adds framebuffer driver for Fujitsu Carmine/Coral-P(A)/Lime
>>> graphics controllers. Lime GDC support is known to work on PPC440EPx
>>> based lwmon5 and MPC8544E based socrates embedded boards, both equipped
>>> with Lime GDC. Carmine/Coral-P PCI GDC support is known to work on
>>> PPC440EPx based Sequoia board and also on x86 platform.
>>>
>>> Signed-off-by: Anatolij Gustschin <agust@denx.de> ---
>>> There are some PPC OF bits, so I'm cc'ing linuxppc-dev list.
>>>       
>> I though there is already carminefb driver.
>>     
>
> FWIW, I quite like Anatolij's driver: it has PCI and OF bindings, plus
> the patch description states that the driver supports Mint controllers
> as well, and I have some hardware that actually needs the support for
> Mint GDCs. (Today we just configure the GDC in the firmware and linux
> use offb.c driver with static setup, w/o ability to change modes e.t.c.)
>
>   
