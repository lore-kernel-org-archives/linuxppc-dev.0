Return-Path: <joel.stan@gmail.com>
Received: from mail-qg0-x229.google.com (mail-qg0-x229.google.com
 [IPv6:2607:f8b0:400d:c04::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 567231A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:14:30 +1100 (AEDT)
Received: by mail-qg0-f41.google.com with SMTP id i50so666194qgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 18:14:27 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <54D8805D.5060207@linux.vnet.ibm.com>
References: <1422600188-27488-1-git-send-email-joel@jms.id.au>
 <54D8805D.5060207@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 11 Feb 2015 12:44:07 +1030
Message-ID: <CACPK8Xd=YLuuX-ABSTE-0_6hZhcwJz126tnpVvW9Mt=dgaewTg@mail.gmail.com>
Subject: Re: [PATCH v2] powernv: Add OPAL soft-poweroff routine
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 9, 2015 at 8:09 PM, Vasant Hegde
<hegdevasant@linux.vnet.ibm.com> wrote:
>> +
>> +#define SOFT_OFF 0x00
>> +#define SOFT_REBOOT 0x01
>
> Better move these macros to opal.h as its coming from OPAL API?

Okay. Mpe has already merged this, so I'll send a follow up.

> Also I think its to merge this code and Anshumans' EPOW driver and create single
> event file.

Agreed, there is consensus that there should be one path for power off
in powernv. I will keep chatting to the guys working on the EPOW
patch.

Cheers,

Joel
