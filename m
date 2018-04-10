Return-Path: <ruscur@russell.cc>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Kw4J44S7zDrbT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:01:18 +1000 (AEST)
Message-ID: <1523336467.3046.0.camel@russell.cc>
Subject: Re: [PATCH v2 9/9] powerpc/powernv: opal-kmsg standardise OPAL_BUSY
 handling
From: Russell Currey <ruscur@russell.cc>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 10 Apr 2018 15:01:07 +1000
In-Reply-To: <20180409052431.26405-10-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
 <20180409052431.26405-10-npiggin@gmail.com>
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

On Mon, 2018-04-09 at 15:24 +1000, Nicholas Piggin wrote:
> OPAL_CONSOLE_FLUSH is documented as being able to return OPAL_BUSY,
> so implement the standard OPAL_BUSY handling for it.
> 
> Cc: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
