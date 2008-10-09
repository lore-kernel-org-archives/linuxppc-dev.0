Return-Path: <timur.tabi@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id BF487DDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 03:28:26 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so25742yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 09:28:25 -0700 (PDT)
Message-ID: <ed82fe3e0810090928v7d50a56ei67ee2c5477491fe7@mail.gmail.com>
Date: Thu, 9 Oct 2008 11:28:24 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Jeff Borlin" <jborlin@aclaratech.com>
Subject: Re: Compact Flash on 8349mITX
In-Reply-To: <19900326.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <19900326.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 9, 2008 at 10:52 AM, Jeff Borlin <jborlin@aclaratech.com> wrote:
>
> I have taken over this effort to get Compact Flash working on the 8349mITX
> board and am running into these same issues.  I can get uBoot to list the
> contents of a CF card, but am running into a couple problems through the
> kernel.  There appears to be an IRQ problem and a general communication
> problem with the CF card, possibly related.

I've heard on-and-off that there are problems with the CF support on
the 8349 ITX, but I've never had the chance to investigate it.

Can you try using the latest BSP kernel and see if the problem is
present there?  Sometimes the BSP has a hacked-up kernel that
addresses hardware issues, but these patches aren't pushed upstream,
so the mainline kernel has problems.

-- 
Timur Tabi
Linux kernel developer at Freescale
