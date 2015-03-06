Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0107.outbound.protection.outlook.com [157.56.110.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EBE61A02E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 11:27:57 +1100 (AEDT)
Date: Thu, 5 Mar 2015 18:06:37 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH v2 1/5] crypto: talitos: Simplify per-channel
 initialization
Message-ID: <20150305180637.e64ed8b57ec79620cbb3ac4b@freescale.com>
In-Reply-To: <1425388897-5434-2-git-send-email-mort@bork.org>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-2-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Horia =?UTF-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  3 Mar 2015 08:21:33 -0500
Martin Hicks <mort@bork.org> wrote:

> There were multiple loops in a row, for each separate step of the
> initialization of the channels.  Simplify to a single loop.
> 
> Signed-off-by: Martin Hicks <mort@bork.org>
> ---

Acked-by: Kim Phillips <kim.phillips@freescale.com>

Kim
