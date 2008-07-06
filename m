Return-Path: <penberg@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 6B1EFDDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 10:03:01 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1683180rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Jul 2008 17:02:59 -0700 (PDT)
Message-ID: <84144f020807051702q1fc6275cv358c5e33dc2677fc@mail.gmail.com>
Date: Sun, 6 Jul 2008 03:02:59 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: the printk problem
In-Reply-To: <20080705185253.GQ14894@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080705125230.GA20166@damson.getinternet.no>
	<alpine.LFD.1.10.0807051045520.2815@woody.linux-foundation.org>
	<19f34abd0807051141h4ccfd0ar28660199f2bbf81f@mail.gmail.com>
	<20080705185253.GQ14894@parisc-linux.org>
Cc: linux-ia64@vger.kernel.org, Vegard Nossum <vegard.nossum@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@medozas.de>, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 05, 2008 at 08:41:39PM +0200, Vegard Nossum wrote:
>> Single letters are bad because it hurts readability and limits the
>> usefulness of the extension.</MHO>

On Sat, Jul 5, 2008 at 9:52 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> I think you need a little warning noise that goes off in your head that
> means "I might be overdesigning this".  Linus' code is elegant and
> solves a problem nicely.

Am I the only one who missed Linus' patch? Did it make it to the list?
