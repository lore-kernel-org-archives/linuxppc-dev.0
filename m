Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC1911400EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 19:49:38 +1000 (EST)
Message-ID: <1397555363.14218.6.camel@pasglop>
Subject: Re: [PATCH 1/1] powerpc: Increase COMMAND_LINE_SIZE to 2048 from 512.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Date: Tue, 15 Apr 2014 19:49:23 +1000
In-Reply-To: <534C2FEB.2000803@canonical.com>
References: <cover.1397260361.git.joseph.salisbury@canonical.com>
 <84356b1cb9452226d54641a71e4b1363e78d4417.1397260362.git.joseph.salisbury@canonical.com>
 <534C2FEB.2000803@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-14 at 14:58 -0400, Joseph Salisbury wrote:
> 
> After further review, it appears ppc does not actually use the define
> in
> the ppc headers but uses the common generic
> default(include/uapi/asm-generic/setup.h).  COMMAND_LINE_SIZE should
> probably become a kernel config option.  Do folks agree that is the
> correct thing to do?  If so, I can re-work the patch.

No objection on my side.

Make sure you remove any unused arch define while at it.

Cheers,
Ben.
