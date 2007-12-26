Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFB0CDDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 03:02:09 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] powerpc: Do not fail build if mkimage is not available
Date: Wed, 26 Dec 2007 17:01:33 +0100
References: <200712261453.41849.mb@bu3sch.de> <200712261635.43188.mb@bu3sch.de>
	<je4pe530vq.fsf@sykes.suse.de>
In-Reply-To: <je4pe530vq.fsf@sykes.suse.de>
MIME-Version: 1.0
Message-Id: <200712261701.33669.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, paulus@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 December 2007 16:56:57 Andreas Schwab wrote:
> > That would help a lot not wasting my time.
> 
> How about testing your changes first?

Stop the bullshit, please.
I tested this and it obviously works very well for me.
I even posted it for review on this list and nobody complained,
including you.

But I see what you are complaining about, now.
It would also error out, if mkimage was installed (which is not the
case for me. That's the whole reason for me making this patch!).

Are you OK with the new version I just sent?

-- 
Greetings Michael.
