Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F5B9B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 05:44:04 +1000 (EST)
Received: by vxi32 with SMTP id 32so2020761vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 12:44:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110719125447.19c964d1@schlenkerla.am.freescale.net>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-14-git-send-email-dbaryshkov@gmail.com>
	<20110719125447.19c964d1@schlenkerla.am.freescale.net>
Date: Fri, 22 Jul 2011 23:44:01 +0400
Message-ID: <CALT56yMxttzC+WZMhja3-PqneMMba5rs9j25RiSAUrwEA_jyaw@mail.gmail.com>
Subject: Re: [PATCH 13/14] 85xx: consolidate of_platform_bus_probe calls
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/19/11, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 19 Jul 2011 12:53:50 +0400
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
>
>> +static struct of_device_id __initdata mpc85xx_common_ids[] = {
>> +	{ .type = "soc", },
>> +	{ .compatible = "soc", },
>> +	{ .compatible = "simple-bus", },
>> +	{ .compatible = "gianfar", },
>> +	{ .compatible = "fsl,qe", },
>> +	{ .compatible = "fsl,cpm2", },
>> +	{},
>> +};
>
> Same comment as for 83xx regarding localbus and compatibility with old
> device trees.

I checked for in-kernel device trees. Unless I miss something, there are no
leftovers from this list. (83xx provided no simple-bus property for localbus,
so your argument is valid there). If we should care about strange cases,
not even blessed by kernel trees, I can add some of the old probes back.

What do you thing?

-- 
With best wishes
Dmitry
