Date: Thu, 1 Aug 2002 10:14:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: __cli on 4xx - MSR:CE?
Message-ID: <20020801001400.GM27711@zax>
References: <1028054814.13540.131.camel@granite.austin.ibm.com> <3D46E96B.1020504@dslextreme.com> <20020731005244.GA27711@zax> <1028130543.13540.168.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1028130543.13540.168.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 31, 2002 at 10:49:02AM -0500, Hollis Blanchard wrote:
>
> On Tue, 2002-07-30 at 19:52, David Gibson wrote:
> >
> > If critical interrupts are disabled everywhere that normal interrupts
> > are disabled, there seems little point in having them.
>
> Sure, I understand that. Will there then be a "__crit_cli" for when you
> really don't want exceptions of any kind? And __save_and_crit_cli ?

I think that has to be up to whoever first implements a real system
with critical interrupts.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
