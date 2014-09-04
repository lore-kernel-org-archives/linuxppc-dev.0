Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews08.kpnxchange.com (cpsmtpb-ews08.kpnxchange.com
 [213.75.39.13])
 by lists.ozlabs.org (Postfix) with ESMTP id 93D4F1A0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 08:29:41 +1000 (EST)
Message-ID: <1409869776.5546.123.camel@x220>
Subject: Re: [4/5] IBM Akebono: Add the Akebono platform
From: Paul Bolle <pebolle@tiscali.nl>
To: Alistair Popple <alistair@popple.id.au>
Date: Fri, 05 Sep 2014 00:29:36 +0200
In-Reply-To: <10214508.Vq3Ynjy2Co@mexican>
References: <1394077948-8395-5-git-send-email-alistair@popple.id.au>
 <1398936447.4121.12.camel@x220> <10214508.Vq3Ynjy2Co@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alistair,

On Fri, 2014-05-02 at 10:35 +1000, Alistair Popple wrote:
> On Thu, 1 May 2014 11:27:27 Paul Bolle wrote:
> > On Thu, 2014-03-06 at 14:52 +1100, Alistair Popple wrote:
> > > This patch adds support for the IBM Akebono board.
> > > +	select IBM_EMAC_RGMII_WOL
> > 
> > The patch that added this symbol (and the related driver) was submitted
> > in https://lkml.org/lkml/2014/2/21/25 . It's not (yet) included in
> > linux-next. Is it queued somewhere else?
> 
> To be honest I'm not sure. I will follow this up on the netdev list.

I noticed that this symbol (and its driver) are still not in v3.17-rc3
nor in next-20140904. Any update on this?

Thanks,


Paul Bolle
