Message-ID: <397DA8F8.E68EF85A@francetelecom.fr>
Date: Tue, 25 Jul 2000 16:49:29 +0200
From: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
References: <397D98FA.35AEF244@francetelecom.fr> <20000725144131.11499@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >In the kernel for PPC, a lot a code is here just to do what doing RTAS :
> >pci config,
> >via (CUDA and PMU) (no need if no ADB keyboard), ...
> >When doing embedded systems, this drivers is very big and can be saving by
> >using
> >RTAS which i think is a very good thing in  CHRP specification. It's
> >strange that
> >apple do not provide it fully.
>
> Well, they didn't care about it. Note that Macs are far from beeing
> embedded boxes ;)

Yes, but i'm using embedded term for small system that doing dedicate task
and only one (for example firewall, gateway, ... in only 50-100k kernel size).

I'm actually experienced that with G4 with 4 network card.

JP


--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
