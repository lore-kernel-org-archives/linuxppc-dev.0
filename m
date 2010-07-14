Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17323B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 22:50:34 +1000 (EST)
In-Reply-To: <4C3CB69D.4060400@freescale.com>
References: <1279047011-28989-1-git-send-email-msm@freescale.com>
	<4C3CB69D.4060400@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D187302D-1F57-443E-806D-4DED6E45FB82@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc:prom Export device tree physical	address via proc
Date: Wed, 14 Jul 2010 14:51:55 +0200
To: Timur Tabi <timur@freescale.com>
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +	if (prop)
>> +		prom_remove_property(node, prop);
>> +		prop = of_find_property(node, "linux,devietree-end", NULL);
>
> Either the indentation is wrong, or you're missing some braces here

You're missing a "c" as well (and a dash).


Segher
