Subject: Re: get_pteptr prototype
From: Hollis Blanchard <hollis@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030108234908.GA1088@zax.zax>
References: <1041893967.1207.42.camel@granite.austin.ibm.com>
	<20030107005751.GP22215@zax.zax>
	<1042040929.1021.80.camel@granite.austin.ibm.com>
	<20030108234908.GA1088@zax.zax>
Content-Type: text/plain
Date: 08 Jan 2003 18:11:25 -0600
Message-Id: <1042071086.1207.206.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-01-08 at 17:49, David Gibson wrote:
> On Wed, Jan 08, 2003 at 09:48:48AM -0600, Hollis Blanchard wrote:
> > It's simply a wrapper around successive pte/pmd/pgd_offset calls, with
> > some error checking. Are you saying those calls are not the correct way
> > to get the PTE pointer for an address?
>
> Trouble is that this will break badly in 2.5 where we use large-page
> entries for the lowmem mapping.

I'm happy to change it to something 2.5-friendly if someone can suggest
how...

Alternatively I can add 405LP to the XMON/KGDB/BDI2000 list of ifdefs
that map the whole kernel writable, which would be overkill but avoid
adding PTE manipulations.

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
