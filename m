Date: Fri, 12 Dec 2003 16:05:34 +0100
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] boot/ld.script dependency missing
Message-ID: <20031212150534.GA23649@suse.de>
References: <20031201212931.GA10959@suse.de> <20031203160958.GF912@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20031203160958.GF912@stop.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, Dec 03, Tom Rini wrote:

> On Mon, Dec 01, 2003 at 10:29:31PM +0100, Olaf Hering wrote:
>
> > fiddling with ld.script doesnt trigger a rebuild of the boot files.
>
> This looks to be an incomplete patch.  Please fix the rest of
> arch/ppc/boot/ and verify that arch/ppc64/boot/ doesn't have the issue
> as well.  Thanks.

The patch for 2.6 is complete, others either do not need the ld.script,
or they already have the dependency.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
