Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 914B22C01D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 13:20:12 +1000 (EST)
Message-ID: <1341890402.2561.2.camel@pasglop>
Subject: Semantics of lv1_pause()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoff@infradead.org>
Date: Tue, 10 Jul 2012 13:20:02 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geoff !

Do you have access to any kind of documentation regarding the precise
semantics of lv1_pause() ?

I'm fixing various issues with our idle loops, among other things,
because we are soft-disabled when we hit ppc_md.powersave() but not
hard-disabled, there could be an interrupt marked as pending and not
taken yet.

Will that work properly ? I have this understanding that it might
not ... but heh.

Also if I call lv1_pause() with MSR_EE off, will it work ? Will it
return with MSR_EE on like H_CEDE does on pseries ?

Cheers,
Ben.
