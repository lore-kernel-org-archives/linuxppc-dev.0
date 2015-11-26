Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0131.outbound.protection.outlook.com [157.56.110.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 185EA1A03AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 20:29:15 +1100 (AEDT)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH V2] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Thu, 26 Nov 2015 09:29:09 +0000
Message-ID: <BLUPR03MB1496BFEB452577A73497A27E1040@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
 <20151126090805.GJ3869@ubuntu>
In-Reply-To: <20151126090805.GJ3869@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks.
I just sent the new patch.

> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Thursday, November 26, 2015 5:08 PM
> To: Jia Hongtao-B38951
> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; devicetree@vger.kernel.org; Wood Scott-B07421
> Subject: Re: [PATCH V2] cpufreq: qoriq: Register cooling device based on
> device tree
>=20
> On 26-11-15, 14:27, Jia Hongtao wrote:
> > +static void qoriq_cpufreq_ready(struct cpufreq_policy *policy) {
> > +	struct cpu_data *cpud =3D policy->driver_data;
> > +	struct device_node *np =3D of_get_cpu_node(policy->cpu, NULL);
> > +
> > +	if (WARN_ON(!np))
> > +		return;
>=20
> Drop this and add my:
>=20
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> --
> viresh
