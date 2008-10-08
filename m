Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id ED87CDE803
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 07:14:41 +1100 (EST)
Received: by gxk14 with SMTP id 14so11706977gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 13:14:40 -0700 (PDT)
Message-ID: <ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
Date: Wed, 8 Oct 2008 15:14:40 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
In-Reply-To: <1223496186.8157.82.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 8, 2008 at 3:03 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> No. Instead, send a patch that fixes the defconfig's to explicitely set
> those to "n". As to whether those should be defaults or not, this is a
> different discussion (I'm almost tempted to have everything default to
> y).

But this is the reason I sent you the patch in the first place.  I
think "default y" is wrong and doesn't make any sense, so I'm asking
you for a technical reason why PMAC and CHRP should default to yes.
That is the focus of my patch.  The defconfig changes are just to
clean up the mess that "default y" left behind.

-- 
Timur Tabi
Linux kernel developer at Freescale
