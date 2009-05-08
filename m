Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C54F6DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 17:51:28 +1000 (EST)
Date: Fri, 8 May 2009 09:50:36 +0200
From: Benjamin Krill <ben@codiert.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Fix wrong register read address and add interrupt
	acknowledge.
Message-ID: <20090508075036.GX14906@codiert.org>
References: <20090505191116.GA7267@codiert.org>
	<ed82fe3e0905051224j30a54ef3s3d5e6c88987ea65a@mail.gmail.com>
	<20090505230919.GE14017@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090505230919.GE14017@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, arnd@arndb.de,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Josh Boyer | 2009-05-05 19:09:19 [-0400]:

>On Tue, May 05, 2009 at 02:24:04PM -0500, Timur Tabi wrote:
>>On Tue, May 5, 2009 at 2:11 PM, Benjamin Krill <ben@codiert.org> wrote:
>
>That is quite true.  Although resending the patch just for that seems overkill.
>The maintainer can edit the summary rather easily.

Ben, could you please merge this patch in your next tree?


cheers
  ben
