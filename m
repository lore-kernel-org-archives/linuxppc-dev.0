Return-Path: <timur.tabi@calxeda.com>
Received: from smtp141.iad.emailsrvr.com (smtp141.iad.emailsrvr.com
 [207.97.245.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 51DDD2C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 02:30:32 +1100 (EST)
Message-ID: <510FD412.4000505@calxeda.com>
Date: Mon, 04 Feb 2013 09:30:26 -0600
From: Timur Tabi <timur.tabi@calxeda.com>
MIME-Version: 1.0
To: Stef van Os <stef.van.os@prodrive.nl>
Subject: Re: [PATCH v2 1/1] powerpc/85xx: Board support for ppa8548
References: <1359920347-15340-1-git-send-email-stef.van.os@prodrive.nl>
In-Reply-To: <1359920347-15340-1-git-send-email-stef.van.os@prodrive.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/03/2013 01:39 PM, Stef van Os wrote:

> +	pci0: pci@fe0008000 {
> +		status = "disabled";
> +	};
> +
> +	pci1: pci@fe0009000 {
> +		status = "disabled";
> +	};
> +
> +	pci2: pcie@fe000a000 {
> +		status = "disabled";
> +	};

I was hoping you'd follow my example and include a comment indicating 
why the PCI devices are all disabled.

> +static void ppa8548_show_cpuinfo(struct seq_file *m)
> +{
> +	uint svid, phid1;

Please don't used unsized integers for hardware registers.

	uint32_t svid, phid1;


-- 
Timur Tabi
