Return-Path: <glikely@secretlab.ca>
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com
 [IPv6:2a00:1450:400c:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D3EC2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 21:40:50 +1000 (EST)
Received: by mail-we0-f169.google.com with SMTP id n57so6877599wev.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 04:40:46 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 1/5] ibmebus: convert of_platform_driver to platform_driver
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rob Herring <robherring2@gmail.com>
In-Reply-To: <1371014978.8250.175.camel@pasglop>
References: <1366596798-9457-1-git-send-email-robherring2@gmail.com>
 <1366596798-9457-2-git-send-email-robherring2@gmail.com>
 <CAL_JsqKDF=hPEM0Jz-zZSXBCXBZ=gBjLWL6QDvq+nFWkqY3DMw@mail.gmail.com>
 <1366911329.2869.31.camel@pasglop> <517980B0.3000401@gmail.com>
 <1366920741.2869.32.camel@pasglop> <517995D0.8020307@gmail.com>
 <CAL_JsqKXt-gFL4y_k-_dFktpk1JD_S2G+hUsoOavw8QugFMOKA@mail.gmail.com>
 <1371014978.8250.175.camel@pasglop>
Date: Wed, 12 Jun 2013 12:40:43 +0100
Message-Id: <20130612114043.9E69A3E0A56@localhost>
Cc: Roland Dreier <roland@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Raisch <raisch@de.ibm.com>, Hoang-Nam Nguyen <hnguyen@de.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Sean Hefty <sean.hefty@intel.com>,
 linuxppc-dev@lists.ozlabs.org, Hal Rosenstock <hal.rosenstock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 12 Jun 2013 15:29:38 +1000, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Wed, 2013-05-22 at 07:26 -0500, Rob Herring wrote:
> > > git://sources.calxeda.com/kernel/linux.git of-platform-removal
> > 
> > Ben,
> > 
> > Did you have a chance to test this? I want to get this into -next.
> 
> I tested the one in for-next (sorry for the high latency). Works fine.
> 
> Ack.

Added acks and applied to my for-next branch. Thanks!

g.
