Return-Path: <rui.zhang@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scqwm4Qr6zDsZ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 12:44:40 +1000 (AEST)
Message-ID: <1474253068.23153.2.camel@intel.com>
Subject: Re: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
From: Zhang Rui <rui.zhang@intel.com>
To: Leo Li <pku.leo@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Jia Hongtao <hongtao.jia@nxp.com>, devicetree@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>, Scott
 Wood <scott.wood@nxp.com>, Eduardo Valentin <edubezval@gmail.com>, Kumar
 Gala <galak@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Date: Mon, 19 Sep 2016 10:44:28 +0800
In-Reply-To: <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
 <20160608195241.GA6805@rob-hp-laptop>
 <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 三, 2016-09-14 at 11:40 -0500, Leo Li wrote:
> On Wed, Jun 8, 2016 at 2:52 PM, Rob Herring <robh@kernel.org> wrote:
> > 
> > On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
> > > 
> > > For different types of SoC the sensor id and endianness may vary.
> > > "#thermal-sensor-cells" is used to provide sensor id information.
> > > "little-endian" property is to tell the endianness of TMU.
> > > 
> > > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > > ---
> > > Changes for V2:
> > > * Remove formatting chnages.
> > > 
> > >  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7
> > > +++++++
> > >  1 file changed, 7 insertions(+)
> > Acked-by: Rob Herring <robh@kernel.org>
> Hi Zhang Rui,
> 
> Since you have applied the driver patch, can you also apply the
> binding patch?  The binding is supposed to go with the driver.
> 

Do you mean I should take both patch 1/7 and 7/7? I can not see the
other patches in this patch set.

thanks,
rui
