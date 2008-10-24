Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 623FADDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 08:53:50 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so998718rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 14:53:49 -0700 (PDT)
Message-ID: <fa686aa40810241453o876ae14tce3df7723b0f621b@mail.gmail.com>
Date: Fri, 24 Oct 2008 15:53:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [powerpc] GPIO: Adding new Xilinx driver
In-Reply-To: <20081024214159.GA15204@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081024195908.7D1A1142806C@mail74-wa4.bigfish.com>
	<20081024214159.GA15204@oksana.dev.rtsoft.ru>
Cc: Kiran Sutariya <kirans@xilinx.com>, linuxppc-dev@ozlabs.org,
	John Linn <john.linn@xilinx.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 3:41 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Fri, Oct 24, 2008 at 12:59:00PM -0700, John Linn wrote:
>> This driver supports the Xilinx XPS GPIO IP core which has the typical
>> GPIO features.
>>
>> Signed-off-by: Kiran Sutariya <kirans@xilinx.com>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>
> Looks good. Just few comments below.
>
<snip>
>
> If nothing has changed, we should place the arch-specific GPIO
> drivers into the arch/. So, Kconfig entry should go into the
> arch/powerpc/platforms/Kconfig.
>
> and the driver itself into arch/powerpc/sysdev/.

This isn't just a powerpc driver.  It is also used by microblaze so
I'd like to keep it in the common directory (Microblaze is in the
process of being reviewed for merging).

Thanks for the comments.
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
