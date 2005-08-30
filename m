Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4150F680E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 17:44:49 +1000 (EST)
Date: Tue, 30 Aug 2005 00:44:47 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050830074447.GC27899@gate.ebshome.net>
References: <20050727125746.54329281.akpm@osdl.org>
	<0048AEBE-072F-4250-9D32-EC019D0BDBB9@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0048AEBE-072F-4250-9D32-EC019D0BDBB9@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
	maintained
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 29, 2005 at 08:46:22PM -0500, Kumar Gala wrote:
> 
> On Jul 27, 2005, at 2:57 PM, Andrew Morton wrote:
> 
> >Kumar Gala <galak@freescale.com> wrote:
> >
> >>
> >>The following board ports are no longer maintained or have become
> >> obsolete:
> >>
> >> adir
> >> ash
> >> beech
> >> cedar
> >> ep405
> >> k2
> >> mcpn765
> >> menf1
> >> oak
> >> pcore
> >> rainier
> >> redwood
> >> sm850
> >> spd823ts
> >>
> >> We are there for removing support for them.
> >>
> >
> >I'll merge all these into -mm for now, but will hold off sending  
> >any of
> >them upstream pending confirmation of which patches we really want to
> >proceed with.
> 
> No one has screamed about anything but ep405 so all the others should  
> go to Linus now.

Matt told me he would probably get ash soon. There is even a path in 
the -mm queue which should fix ethernet on this board.

Matt?

-- 
Eugene
