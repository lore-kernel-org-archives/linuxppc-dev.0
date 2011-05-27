Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 1EC40B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 May 2011 00:45:06 +1000 (EST)
Message-ID: <4DDFB49D.8010104@ovro.caltech.edu>
Date: Fri, 27 May 2011 07:26:37 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: MPC8308 bursting question
References: <OF1B4E92C8.698C0AE4-ON8825789D.00209684-8825789D.002206EF@selinc.com>
In-Reply-To: <OF1B4E92C8.698C0AE4-ON8825789D.00209684-8825789D.002206EF@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bruce,

> This isn't really a Linux PPC question, but this is the smartest mailing
> list I know for asking PPC hardware questions, so here goes.
>
> We're using an MPC8308 and want to use the DMA engine to move data in and
> out of an FPGA hanging on the local bus.  Our bandwidth/local bus burden
> calculations were done assuming that we could use bursting.  So I've setup
> a UPM to do single beat and burst reads/writes.  I've also configured my
> DMA TCD to use a data transfer size of 32-bytes when accessing the FPGA.
> The problem I'm having is I can't seem to get the UPM to ever trigger the
> burst write sequence using the DMA.  Single beat reads and writes work
> okay, but no bursting.  In fact, the only thing I've been able to find in
> the manual that causes a burst transaction is a cache line miss, which is
> wholly in the purview of the core and really does me no good.
>
> Does anyone know of any way (short of issuing a run command to the UPM via
> MxMR) to force a burst transaction on the 8308?  Am I just being dumb and
> missing something totally fundamental?

Read my MPC8349EA UPM setup notes and see if you have used
similar settings (I assume the local bus UPMs are similar):

http://www.ovro.caltech.edu/~dwh/carma_board/carma_sys.pdf

Do you have a Modelsim simulation of your interface?
I have a VHDL bus-functional-model I wrote that I can
send you.

Cheers,
Dave
