Message-ID: <397D98FA.35AEF244@francetelecom.fr>
Date: Tue, 25 Jul 2000 15:41:14 +0200
From: FASSINO Jean-Philippe <jeanphilippe.fassino@francetelecom.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTAS on PowerMac Newworld
References: <397D6A7A.CBF58A52@francetelecom.fr> <20000725131626.8292@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >
> >Just a question about RTAS on PowerMac G4,
> >does linux kernel can call RTAS function ?
> >And if not, why ?
> >I'm trying to do it and that fail...
>
> RTAS in not correctly implemented in those machines. Apple is apparently
> abandonning it, the implementation in ROM for all core99 machines is
> bogus. What do you want to use RTAS for ?

In the kernel for PPC, a lot a code is here just to do what doing RTAS :
pci config,
via (CUDA and PMU) (no need if no ADB keyboard), ...
When doing embedded systems, this drivers is very big and can be saving by
using
RTAS which i think is a very good thing in  CHRP specification. It's
strange that
apple do not provide it fully.

JP




--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
