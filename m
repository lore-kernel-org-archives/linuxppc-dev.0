Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E8552C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 May 2013 07:50:44 +1000 (EST)
Message-ID: <1368222633.4524.53.camel@pasglop>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Sat, 11 May 2013 07:50:33 +1000
In-Reply-To: <1368222580.4524.52.camel@pasglop>
References: <1368134856.654.11@snotra> <1368137220.3715.14.camel@pasglop>
 <20130510141213.GA31597@pek-khao-d1.corp.ad.wrs.com>
 <1368222580.4524.52.camel@pasglop>
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

On Sat, 2013-05-11 at 07:49 +1000, Benjamin Herrenschmidt wrote:
> I would keep the EE_EDGE bit definition. I have no objection to a gradual
> approach however for the other one where we apply it as is now to enable
> coreint while you do a rework to make it better :-)

Note also that I generally don't apply FSL related patches directly, I
rely on Kumar Gala picking them up so he's the one ultimately making
that choice.

Cheers,
Ben.
