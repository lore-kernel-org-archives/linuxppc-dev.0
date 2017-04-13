Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3NCm6L7WzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 11:16:20 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 34so5373015pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:16:20 -0700 (PDT)
Message-ID: <1492046172.8380.16.camel@gmail.com>
Subject: Re: powerpc: Avoid taking a data miss on every userspace
 instruction miss
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>, Anton Blanchard
 <anton@ozlabs.org>, benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 13 Apr 2017 11:16:12 +1000
In-Reply-To: <3vzNHv6zMZz9s9c@ozlabs.org>
References: <3vzNHv6zMZz9s9c@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-06 at 23:06 +1000, Michael Ellerman wrote:
> On Mon, 2017-04-03 at 06:41:02 UTC, Anton Blanchard wrote:
> > From: Anton Blanchard <anton@samba.org>
> > 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/a7a9dcd882a67b68568868b988289f
>

FYI: The version you applied does not have checks for is_write

Balbir Singh. 
