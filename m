Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2C3A267B1E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 00:42:56 +1000 (EST)
Date: Mon, 12 Jun 2006 16:42:54 +0200
Message-ID: <20060612144254.305930@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hbqsyd4uz.wl%tiwai@suse.de>
References: <20060610082223.321730@gmx.net> <s5hbqsyd4uz.wl%tiwai@suse.de>
Subject: Re: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and
	ALSA?
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, rlrevell@joe-job.com,
	alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -------- Original-Nachricht --------
> Datum: Mon, 12 Jun 2006 12:51:16 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Betreff: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and
> ALSA?
> 
> > Well, implementing the dma_mmap_coherent() function isn't the
> > problem, because it is already implemented for the ARM
> > architecture.
> 
> Actually, I wrote dma_coherent_mmap patch long time ago but it has
> been left forgotten.  The patch attached below seems applicable to
> 2.6.17 tree, but I'm not sure whether it still works properly.
> It's untested on most of architectures.

Thanks, that helps me a lot!

> > But as far as I understand this would require a rewrite of all the
> > ALSA drivers (or at least a rewrite of the ALSA's DMA helper
> > functions).
> 
> Yes.  The change of ALSA side has been also on my tree.  But it was
> still pending since I'm not satisfied with the design yet.
> If you're interested in it, let me know.  I'll post the patch.

Yes, please! Then I can test, if the dma_mmap_coherent() patch works on
my non cache coherent powerpc machine. Do you think the DMA Layer/ALSA patches will go upstream in one of the next ALSA/Linux kernel versions?

Thanks!

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
