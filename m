Date: Wed, 29 May 2002 16:16:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Malek <dan@embeddededge.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMBench and CONFIG_PIN_TLB
Message-ID: <20020529231600.GW5997@opus.bloom.county>
References: <20020529030838.GZ16537@zax> <3CF4E842.3070207@embeddededge.com> <15605.24191.948013.249297@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15605.24191.948013.249297@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 30, 2002 at 09:04:31AM +1000, Paul Mackerras wrote:

> available.  Tom Rini mentioned the other day that some 8xx processors
> only have 8 (I assume he meant 8 data + 8 instruction).

Quite probably, yes. :)

[snip]
> processor, which has 64.  I don't think he was advocating removing the
> config option on the 8xx processors (actually, why is there the "860
> only" comment in there?)

Because the current code goes and pins 8 or so TLBs (4 data, 4
instruction) which won't fly on the ones which only allow for 2/8 to be
pinned.  So 860 is a slight mislabing, if I read it all correctly.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
