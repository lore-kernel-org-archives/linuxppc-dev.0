Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-02.nyroc.rr.com (ms-smtp-02.nyroc.rr.com [24.24.2.56])
	by ozlabs.org (Postfix) with ESMTP id 8F2702BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Dec 2004 04:48:13 +1100 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647421@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A647421@whq-msgusr-02.pit.comms.marconi.com>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 12:47:57 -0500
Message-Id: <1104256077.20042.125.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2004-12-28 at 12:28 -0500, Povolotsky, Alexander wrote:
> Hi! (Thanks !) 
> 
> I guess I need some more education - since I am getting my problem right at
> the boot - is 
> I-Cache enabled (by default ?) for 8xx on 2.6 at the booting ? - I do not
> see anything in .config 
> which controls it (or I am missing it there ?) 
> How (where and at what point during the boot)-) I could disable I-Cache ?
> 

Since you where able to get to the prekernel portion (that was
relocated) I don't think you have a problem with caches, unless for some
reason the pre-kernel can relocate itself, but it doesn't know to
refresh the cache after relocating the actual kernel.

-- Steve
