Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJnNs6YjRzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 06:55:41 +1000 (AEST)
Message-ID: <1493931328.25397.35.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: schindele@nentec.de
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 04 May 2017 15:55:28 -0500
In-Reply-To: <41499955.CTp69um5pn@sherry>
References: <2666241.ms6yMRjznt@sherry> <1715435.xdU3769208@sherry>
 <1493782174.25397.31.camel@buserror.net> <41499955.CTp69um5pn@sherry>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Freescale mpc8315 IRQ0 setup
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-04 at 17:06 +0200, Juergen Schindele wrote:
> Am Dienstag, 2. Mai 2017, 22:29:34 schrieb Scott Wood:
> > On Tue, 2017-05-02 at 14:43 +0200, Juergen Schindele wrote:
> > > Dear Scott,
> > > sorry for the delay but i am not very familiar with the formating.
> > > I passed the patch trough checkpatch.pl and there was no more error.
> > > pease find patch in attached file.
> > > Thanks
> > 
> > Documentation/process/submitting-patches.rst explains the way to format
> > and
> > submit kernel patches.
> > 
> > Also, why the unrelated change to a print statement in
> > ipic_set_irq_type()?
> > 
> > -Scott
> 
> The second diff is not completely unrelated because when i was
> investigating 
> the problem i saw only a message "edge sense not supported" but you dont
> know on which interrupt he is complaining about. So i added this to find
> out 
> who the suspect is.

That's fine but it's still fixing a different problem than "irq0 setup" and
should be a separate patch.

> Corrected patch

Again, please read Documentation/process/submitting-patches.rst.  Patches
should be inline, not attached.  The subject line should be something like
"powerpc/ipic: Configure "EDGE" capabilities for IRQ0 (like IRQ1-7)" and there
should be more description in the body of the changelog.

-Scott
