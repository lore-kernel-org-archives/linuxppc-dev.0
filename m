Return-Path: <dja@axtens.net>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPlvl4gvCzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 19:05:55 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id e1so5653708qkh.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 00:05:55 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH v2] powerpc: Add POWER9 architected mode to cputable
In-Reply-To: <20170217020135.6361-1-ruscur@russell.cc>
References: <20170217020135.6361-1-ruscur@russell.cc>
Date: Fri, 17 Feb 2017 19:05:48 +1100
Message-ID: <878tp58co3.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Russell,

This seems to go Power8, Power9, Power7 - is that intentional?

Regards,
Daniel

>  		.platform		= "power8",
...
> +		.platform		= "power9",
...
>  	{	/* Power7 */
