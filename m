Date: Tue, 30 Mar 2004 08:49:42 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: Jos Beck <jos_beck@euronet.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI on MPC8250VR
Message-ID: <20040330064942.GA32569@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <40684302.2040701@euronet.nl>
Mime-Version: 1.0
In-Reply-To: <40684302.2040701@euronet.nl>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In this list I only read about trouble with the 8250 PCI :)

In our case, we are using PCI quite successfully for simple data pushing
to another device (8245 writes) and DMA is only limited by a (known)
silicon bug in the DSP revision.

Master-Read operations from the PPC memory over PCI have currently a
problem, but we are not able to pinpoint it to either the PPC or the
DSP.

I don't think PCI on the PPC side is a problem though :-/

  marc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
