Date: Fri, 30 Mar 2001 14:40:41 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Gall <gall@rochcivictheatre.org>
Cc: Tony Mantler <nicoya@apia.dhs.org>,
	Kaoru Fukui <k_fukui@highway.ne.jp>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Success kernel-243pre8-SMP(patch)(Re: spin_lock problem inrecent kernel
Message-ID: <20010330144041.A23536@suse.de>
References: <20010329021803.Postino-029218@smtp01.highway.ne.jp> <3AC2352D.384B57CA@rochcivictheatre.org> <20010329222953.Postino-006016@smtp01.highway.ne.jp> <3AC33CA7.E5DF4C03@vnet.ibm.com> <20010330062000.Postino-000633@smtp01.highway.ne.jp> <v04003a21b6e9a03a5dae@[24.70.162.12]> <3AC3F85F.88D020BE@rochcivictheatre.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AC3F85F.88D020BE@rochcivictheatre.org>; from gall@rochcivictheatre.org on Thu, Mar 29, 2001 at 09:07:11PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 29, Tom Gall wrote:

>
> Tony Mantler wrote:
>
> > That's #if*n*def, not #ifdef. :)
> >
> > And speaking of #ifndef, why are these spinlocks here in the first place
> > and/or why do they now need to be removed? Just suddenly removing locks
> > because of a new deadlock condition gets my spidey senses tingling.
>
> It all stinks to high heaven, that's for sure. Removing the
> page_table_lock from being locked in ioremap, saves us from stopping
> cold during the first ioremap (at least on Power3). And as far as the
> second, I'm in complete agreement...  warning warning danger will
> robinson!

That patch solved the boot problem on my 43p 260. Last progress output
was MMU:exit.
It boots and runs fine now.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
