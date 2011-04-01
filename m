Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id 184BAB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 04:30:27 +1100 (EST)
Received: by gwj21 with SMTP id 21so1834643gwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Apr 2011 10:30:24 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1301336863-1886-1-git-send-email-tmarri@apm.com>
	<f0313241cc289cd316831ee445935465@mail.gmail.com>
In-Reply-To: <f0313241cc289cd316831ee445935465@mail.gmail.com>
MIME-Version: 1.0
Date: Fri, 1 Apr 2011 10:30:23 -0700
Message-ID: <5eb399c8b8073bc76e4ededa2ba5968d@mail.gmail.com>
Subject: RE: [PATCH v10 02/10] USB/ppc4xx: Add Synopsys DWC OTG driver
	framework
To: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, Mark Miesfeld <mmiesfeld@apm.com>,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----Original Message-----
From: Keshava Munegowda [mailto:keshava_mgowda@ti.com]
Sent: Tuesday, March 29, 2011 3:46 AM
To: tmarri@apm.com; linux-usb@vger.kernel.org;
linuxppc-dev@lists.ozlabs.org
Cc: greg@kroah.com; Fushen Chen; Mark Miesfeld
Subject: RE: [PATCH v10 02/10] USB/ppc4xx: Add Synopsys DWC OTG driver
framework

> +static irqreturn_t dwc_otg_common_irq(int _irq, void *dev)
> +{
> +	struct dwc_otg_device *dwc_dev = dev;
> +	int retval;

Tabify the declarations;

[Marri] I wonder what tool do use. I did not see warnings with
checkpatch.pl.
