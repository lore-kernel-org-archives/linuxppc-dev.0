Date: Wed, 3 Dec 2003 09:09:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] boot/ld.script dependency missing
Message-ID: <20031203160958.GF912@stop.crashing.org>
References: <20031201212931.GA10959@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031201212931.GA10959@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 01, 2003 at 10:29:31PM +0100, Olaf Hering wrote:

> fiddling with ld.script doesnt trigger a rebuild of the boot files.

This looks to be an incomplete patch.  Please fix the rest of
arch/ppc/boot/ and verify that arch/ppc64/boot/ doesn't have the issue
as well.  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
