Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D2CEE2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 07:26:15 +1000 (EST)
Message-ID: <1341264368.2588.49.camel@pasglop>
Subject: Re: [PATCH] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 03 Jul 2012 07:26:08 +1000
In-Reply-To: <40388C8A-6D3B-409E-9C6D-45005E1F6016@suse.de>
References: <1341262574-2841-1-git-send-email-stuart.yoder@freescale.com>
 <40388C8A-6D3B-409E-9C6D-45005E1F6016@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-02 at 22:59 +0200, Alexander Graf wrote:
> This should go into an #ifdef __ASSEMBLY__ block, right? :)

We almost never use #ifdef __ASSEMBLY__, we use it the other way around,
to prevent C stuff from being included in assembly. The other way around
is legit since things might be used in inline asm for example.

Cheers,
Ben.
