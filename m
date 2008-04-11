Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8A68DDF1F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 04:28:45 +1000 (EST)
In-Reply-To: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6cff5e9f9428c55ad36966c47e9afbcd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Date: Fri, 11 Apr 2008 20:28:22 +0200
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> add vendor prefix to the compat node check for uniqueness,

> -	compatible = "mpc86xx";
> +	compatible = "wrs,sbc8641";

Either use the ticker thing (uppercase, "WIND,xxxx"), or, if you
prefer a lowercase name without that little extra namespace protection,
please use something more descriptive -- there are only so many
three-letter acronyms: "windriver,xxxx"?


Segher
