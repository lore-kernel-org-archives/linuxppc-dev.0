Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcn9r1GkpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 07:41:36 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id h4so17925504oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:41:36 -0700 (PDT)
Date: Tue, 30 May 2017 16:41:32 -0500
From: Rob Herring <robh@kernel.org>
To: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Cc: David Miller <davem@davemloft.net>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "oss@buserror.net" <oss@buserror.net>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: net: move FMan binding
Message-ID: <20170530214132.cxdqh3xyobksrhvu@rob-hp-laptop>
References: <1494855398-26215-1-git-send-email-madalin.bucur@nxp.com>
 <20170515.103048.248884533404807350.davem@davemloft.net>
 <AM5PR0402MB2691006D3DD1CEB8744EF8F4ECFF0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM5PR0402MB2691006D3DD1CEB8744EF8F4ECFF0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 25, 2017 at 12:57:26PM +0000, Madalin-Cristian Bucur wrote:
> > -----Original Message-----
> > From: David Miller [mailto:davem@davemloft.net]
> > Sent: Monday, May 15, 2017 5:31 PM
> > Subject: Re: [PATCH] dt-bindings: net: move FMan binding
> > 
> > From: Madalin Bucur <madalin.bucur@nxp.com>
> > Date: Mon, 15 May 2017 16:36:38 +0300
> > 
> > > Besides the PPC SoCs, the QorIQ DPAA FMan is also present on ARM SoCs,
> > > moving the device tree binding document into the bindings/net folder.
> > >
> > > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> > 
> > What tree is this targetted at for merging?
> 
> I hope Rob Herring will take this into his tree, it's a device tree binding
> change. 

Applied.

Rob
