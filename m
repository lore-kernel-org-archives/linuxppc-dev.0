From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
Date: Sat, 19 Jun 2004 08:53:26 +0200
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.44L0.0406181737520.1334-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0406181737520.1334-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200406190853.32745.oliver@neukum.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Am Freitag, 18. Juni 2004 23:41 schrieb Alan Stern:
> > barriers. Actually, it's worse, you need a full mb() to order them,
> > which is why lately, we made ppc64 writeX() do full sync's ... that sucks
> > but it's near to impossible to get an abstract IO API that would cover
> > our needs here and still make other archs happy it seems...
>
> I recently changed a few mb() calls to wmb(), because they only protected
> data the CPU was writing to be read by the device.  Do you think changing
> all the wmb()'s back to mb()'s would make a difference?

Are these issues documented somewhere?

	Regards
		Oliver

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
