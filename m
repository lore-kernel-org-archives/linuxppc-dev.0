Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070821052514.GC21169@localhost.localdomain>
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
	<acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
	<20070821052514.GC21169@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ae3d7296a5c3e83f19817a04841d099f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Patches for ppc?
Date: Tue, 21 Aug 2007 17:14:41 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's not a question of indivudual files being copied over - things are
> done differently in arch/powerpc.  Things are gradually being ported
> over to arch/powerpc as people get the time - that's why arch/ppc
> isn't gone yet.

And to be blunt, one of the points of arch/powerpc vs. arch/ppc is
to actually leave behind some stuff.  "If no one ports it, no one
wants it".


Segher
