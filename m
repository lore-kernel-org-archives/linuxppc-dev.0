Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0F34DB7BC7
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 19:43:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 14/27] Add book3s_64 specific opcode emulation
Date: Wed, 4 Nov 2009 09:43:46 +0100
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<280C9FF6-1C52-4856-9F60-15DA0659FC31@suse.de>
	<1257284313.7907.80.camel@pasglop>
In-Reply-To: <1257284313.7907.80.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200911040943.46617.arnd@arndb.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 03 November 2009, Benjamin Herrenschmidt wrote:
> (Though glibc can be nasty, afaik it might load up optimized variants of
> some routines with hard wired cache line sizes based on the CPU type)

You can also get application with hand-coded cache optimizations
that are even harder, if not impossible, to fix.

	Arnd <><
