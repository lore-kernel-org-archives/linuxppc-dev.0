Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0BB942C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 07:50:00 +1000 (EST)
Message-ID: <1368222580.4524.52.camel@pasglop>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Sat, 11 May 2013 07:49:40 +1000
In-Reply-To: <20130510141213.GA31597@pek-khao-d1.corp.ad.wrs.com>
References: <1368134856.654.11@snotra> <1368137220.3715.14.camel@pasglop>
 <20130510141213.GA31597@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-10 at 22:12 +0800, Kevin Hao wrote:
> So I would assume you will not pick up these two patches, right?
> http://patchwork.ozlabs.org/patch/235530/
> http://patchwork.ozlabs.org/patch/235532/
> 
> Anyway it is more easier to enable the external proxy by using this method.
> But if you insist, I can respin a patch to use the method you suggested
> since it will definitely reduce the window where the irq is hard disabled.

I would keep the EE_EDGE bit definition. I have no objection to a gradual
approach however for the other one where we apply it as is now to enable
coreint while you do a rework to make it better :-)

Cheers,
Ben.
