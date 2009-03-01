Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 56584DDDF6
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 15:09:11 +1100 (EST)
Received: by gxk1 with SMTP id 1so6229480gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 20:09:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090227235456.4DED2448057@mail135-wa4.bigfish.com>
References: <20090227235456.4DED2448057@mail135-wa4.bigfish.com>
Date: Sat, 28 Feb 2009 21:09:09 -0700
Message-ID: <fa686aa40902282009y6b96129ct7cc602158129dc8f@mail.gmail.com>
Subject: Re: [PATCH] Xilinx: SPI: driver not releasing memory
From: Grant Likely <grant.likely@secretlab.ca>
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akonovalov@ru.mvista.com,
	dbrownell@users.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 27, 2009 at 4:54 PM, John Linn <john.linn@xilinx.com> wrote:
> The driver was not releasing memory when it was removed or
> when there was a failure during probe. This fixes it.
>
> Signed-off-by: John Linn <john.linn@xilinx.com>

Looks good.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

I'll pick this up into my -next branch and ask Ben to pull it in the
next week or so.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
