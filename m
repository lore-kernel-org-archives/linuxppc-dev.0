Return-Path: <edubezval@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8655C1A004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 04:24:28 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so28226387pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 09:24:26 -0800 (PST)
Date: Tue, 24 Nov 2015 09:24:23 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Jia Hongtao <hongtao.jia@freescale.com>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qoriq: Register cooling device based on device
 tree
Message-ID: <20151124172422.GA14845@localhost.localdomain>
References: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
 <1448374697.27264.308.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448374697.27264.308.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2015 at 08:18:17AM -0600, Scott Wood wrote:
> On Tue, 2015-11-24 at 14:55 +0800, Jia Hongtao wrote:
> > Register the qoriq cpufreq driver as a cooling device, based on the
> > thermal device tree framework. When temperature crosses the passive trip
> > point cpufreq is used to throttle CPUs.
> >=20
> > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > Reviewed-by: Scott Wood <scottwood@freescale.com>
>=20
> When did I add "Reviewed-by" to this?

This is typically why I prefer seeing people emailing their reviewed-by
and acked-by to the mailing list in reply to the patch itself, instead
of getting a patch with all the honors already added. :-/

>=20
> -Scott
>=20
