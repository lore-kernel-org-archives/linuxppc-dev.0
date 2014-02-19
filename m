Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A86F2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 00:17:43 +1100 (EST)
Received: by mail-wi0-f178.google.com with SMTP id cc10so570090wib.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 05:17:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140213003253.GL4524@book.gsilab.sittig.org>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
 <20140213003253.GL4524@book.gsilab.sittig.org>
Date: Wed, 19 Feb 2014 17:17:36 +0400
Message-ID: <CAF0T0X5cQcdXU5-XEA2uZAoYSLyk4eONy+Jj6d4GeE-SrBpG2Q@mail.gmail.com>
Subject: Re: [PATCH RFC v7 0/6] MPC512x DMA slave s/g support, OF DMA lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Gerhard

2014-02-13 4:32 GMT+04:00 Gerhard Sittig <gsi@denx.de>:
> For some reason you have kept the DMA maintainers, but dropped
> the dmaengine ML from Cc: -- was this intentional, given that the
> series is specifically about DMA and you want to get feedback?
No, it was not done by intention, I'll fix that in the new version of the
series.

> And you may want to help DT people by not sending purely Linux
> implementation related stuff to them (they already are drinking
> from the firehose).  DT reviewers are foremost interested in
> bindings and policy and remaining OS agnostic, and leave
> mechanical .dts file updates to subsystem maintainers.
Do you mean I should better Cc to devicetree@vger.kernel.org
only parts 3, 4 and 5 of this series? How about cover letter?

Thank you.

Alexander
