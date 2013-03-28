Return-Path: <B29983@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 837562C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 14:02:19 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Phillips Kim-R1AAHA <R1AAHA@freescale.com>
Subject: RE: [PATCH 3/3] cpufreq: Add cpufreq driver for Freescale e500mc SOCs
Date: Thu, 28 Mar 2013 03:02:11 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B0B105983@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364265391-26077-1-git-send-email-Yuantian.Tang@freescale.com>
 <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
 <20130327143236.7cb4613b78ad18d79bfbcc57@freescale.com>
In-Reply-To: <20130327143236.7cb4613b78ad18d79bfbcc57@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "rjw@sisk.pl" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +		return ret;
> > +
> > +	pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static void __exit ppc_corenet_cpufreq_exit(void) {
> > +	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
> > +}
> > +
> > +module_init(ppc_corenet_cpufreq_init);
> > +module_exit(ppc_corenet_cpufreq_exit);
>=20
> this needs to be a module_platform_driver.
>=20
The compatible string is used for clock driver.
This driver can not be a platform_driver.

-Yuantian
