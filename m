Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 81851B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 07:01:28 +1000 (EST)
Received: by vws11 with SMTP id 11so1458211vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 14:01:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 30 Jun 2010 16:00:56 -0500
Message-ID: <AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
To: Alexandre Bounine <abounine@tundra.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 30, 2010 at 3:55 PM, Timur Tabi <timur.tabi@gmail.com> wrote:

> MCSR_MASK is not defined anywhere, so when I compile this code, I get this:

Never mind.  I see that it's been fixed already, and that the patch
that removed MCSR_MASK was posted around the same time that this patch
was posted.


-- 
Timur Tabi
Linux kernel developer at Freescale
