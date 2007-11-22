Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 659D8DDF3E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 04:27:40 +1100 (EST)
Message-ID: <4745BBFB.6060403@scram.de>
Date: Thu, 22 Nov 2007 18:27:23 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH resend 3/4] powerpc: Add EXPORT_SYMBOL for symbols required
	by fs_enet and cpm_uart
References: <4745B42B.8050201@scram.de>
	<fa686aa40711220918l2c7c021euf9ed1e29798e8bc3@mail.gmail.com>
In-Reply-To: <fa686aa40711220918l2c7c021euf9ed1e29798e8bc3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

> Is this really a good idea?  A globally accessable pointer to the region?

No it's not. But drivers are actually using the pointer and due to the
missing export, they currently don't compile as module.

>> +EXPORT_SYMBOL(cpm_setbrg);
> 
> EXPORT_SYMBOL_GPL?

Agreed.

Thanks,
Jochen
