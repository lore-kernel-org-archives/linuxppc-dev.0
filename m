Subject: Re: Trouble compiling kernel for G5.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Berndtsson <stefan@nocrew.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Jens Axboe <axboe@suse.de>
In-Reply-To: <87d69rb7y4.fsf@hades.nocrew.org>
References: <874qv5c9xd.fsf@hades.nocrew.org>
	 <1073778255.17403.28.camel@gaston> <87llofbaok.fsf@hades.nocrew.org>
	 <1073781366.17403.41.camel@gaston>  <87d69rb7y4.fsf@hades.nocrew.org>
Content-Type: text/plain
Message-Id: <1073784645.763.47.camel@gaston>
Mime-Version: 1.0
Date: Sun, 11 Jan 2004 12:30:46 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> ide0, timeout waiting                   for dbdma command stop
> ide-cd: dma error
> hda: DMA disabled
> hda: dma error: status=0x50 { DriveReady SeekComplete }
> hda: dma error: error=0x00
> cdrom_newpc_intr: 4 residual after xfer
> cdrom_newpc_intr: 4 residual after xfer
>
> And hdparm shows the drive to no longer have DMA turned on, which it did
> before running growisofs.
>
> The same command on a B&W G3 runs fine with DMA (2.4.23 kernel).
>
> So, to answer your question, it seems it does not work, no.

Look like an underrun again, or an alignement problem as there
seem to be something weird with the DBDMA on the G5 at least
(there is some "workaround" code in darwin that I haven't been
able to understand fully yet).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
