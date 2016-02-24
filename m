Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA1231A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 07:15:29 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 13:15:27 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 26B3F3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 13:15:26 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OKFPvl29229056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 20:15:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OKFOvm018876
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 15:15:24 -0500
Received: from [9.41.250.246] (manoj.austin.ibm.com [9.41.250.246])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1OKFN4S018667
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 15:15:23 -0500
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 15/18] cxl: Parse device tree and create cxl device(s)
 at boot
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-16-git-send-email-fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CE0F71.60404@linux.vnet.ibm.com>
Date: Wed, 24 Feb 2016 14:15:45 -0600
MIME-Version: 1.0
In-Reply-To: <1456244519-18934-16-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred, Christophe: See comment below.

---
Manoj Kumar

On 2/23/2016 10:21 AM, Frederic Barrat wrote:
> +module_init(cxl_base_init);

Is this a remnant from when there were two modules?
Do you really need two module_init() calls (can't one be called from the
other)?
What is the tear-down portion of this (module_exit)?
