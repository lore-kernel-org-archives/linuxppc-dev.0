Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1112D2C0341
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 20:31:02 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix dynamic relocation
References: <1362790950-23065-1-git-send-email-agraf@suse.de>
 <1362814152.6977.32.camel__2059.78525705195$1362814216$gmane$org@pasglop>
Date: Sat, 09 Mar 2013 10:30:49 +0100
In-Reply-To: <1362814152.6977.32.camel__2059.78525705195$1362814216$gmane$org@pasglop>
 (Benjamin Herrenschmidt's message of "Sat, 09 Mar 2013 18:29:12
 +1100")
Message-ID: <m2ip505392.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> That might fix the mac too..

It does.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
