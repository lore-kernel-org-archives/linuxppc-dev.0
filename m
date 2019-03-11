Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F1AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:39:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF631206BA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 12:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF631206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HyN83HzdzDqBV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 23:39:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
X-Greylist: delayed 739 seconds by postgrey-1.36 at bilbo;
 Mon, 11 Mar 2019 23:36:51 AEDT
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HyKH2h4kzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 23:36:48 +1100 (AEDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BE2F7D2A7C75A6322EBB;
 Mon, 11 Mar 2019 20:36:42 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 20:36:40 +0800
Date: Mon, 11 Mar 2019 12:36:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add
 specific counter sysfs documentation
Message-ID: <20190311123626.00004f70@huawei.com>
In-Reply-To: <20190307114216.GB7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-7-patrick.havelange@essensium.com>
 <20190307114216.GB7851@icarus>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jonathan
 Cameron <jic23@kernel.org>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, Patrick Havelange <patrick.havelange@essensium.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Thierry
 Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 7 Mar 2019 20:42:16 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Wed, Mar 06, 2019 at 12:12:07PM +0100, Patrick Havelange wrote:
> > This adds documentation for the specific prescaler entry.
> > 
> > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > ---
> > Changes v2
> >  - Add doc for prescaler entry
> > ---
> >  .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> > new file mode 100644
> > index 000000000000..2da629d6d485
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
> > @@ -0,0 +1,16 @@
> > +What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
> > +KernelVersion:	5.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Discrete set of available values for the respective Count Y
> > +		configuration are listed in this file. Values are delimited by
> > +		newline characters.
> > +
> > +What:		/sys/bus/counter/devices/counterX/countY/prescaler
> > +KernelVersion:	5.1
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Configure the prescaler value associated with Count Y.
> > +		On the FlexTimer, the counter clock source passes through a
> > +		prescaler that is a 7-bit counter. This acts like a clock
> > +		divider.
> > -- 
> > 2.19.1  
> 
> Hmm, prescalers seem common enough among counter devices to permit these
> attributes to be listed in the sysfs-bus-counter documentation file.
> However, I'd like to wait until we get another counter driver for a
> device with a prescaler before we make that move. From there, we'll have
> a better vantage point to determine a fitting standard prescaler
> attribute behavior.
> 
> So for now, we'll keep these attributes documented here in the
> sysfs-bus-counter-ftm-quaddec file, until the time comes to broach the
> discussion again.
Agreed. As long as the definition is sufficiently non-specific so it can be
moved later.  I'm not sure for example that the docs need to say that it is
a 7 bit counter. That should be apparent from prescaler_available - or at
least possible values should be which is all we need to know.

Jonathan
> 
> William Breathitt Gray


