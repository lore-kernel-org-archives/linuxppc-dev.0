Date: Tue, 16 Jul 2002 07:58:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: consistent_alloc() revisited
Message-ID: <20020716145829.GH20027@opus.bloom.county>
References: <20020716021313.GQ22786@zax> <3D3428FF.5090401@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D3428FF.5090401@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 16, 2002 at 10:09:03AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> >-	if (in_interrupt())
> >-		BUG();
> >+	BUG_ON(in_interrupt());
>
> We should be able to call these functions from interrupt, let's push
> the remainder of the changes though get_free_pages() to make this happen.

I think the only reason we should keep that like it is, for now, is that
fixing that requires other generic changes.  Which Paul was going to ask
Dave M about doing.  Paul, any word back from him yet?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
