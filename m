To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Jens Axboe <axboe@suse.de>
Subject: Re: Trouble compiling kernel for G5.
References: <874qv5c9xd.fsf@hades.nocrew.org>
	<1073778255.17403.28.camel@gaston> <87llofbaok.fsf@hades.nocrew.org>
	<1073781366.17403.41.camel@gaston> <87d69rb7y4.fsf@hades.nocrew.org>
	<1073784645.763.47.camel@gaston>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: Sun, 11 Jan 2004 02:58:35 +0100
In-Reply-To: <1073784645.763.47.camel@gaston> (Benjamin Herrenschmidt's
 message of "Sun, 11 Jan 2004 12:30:46 +1100")
Message-ID: <873canb60k.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>>
>> ide0, timeout waiting                   for dbdma command stop
>> ide-cd: dma error
>> hda: DMA disabled
>> hda: dma error: status=0x50 { DriveReady SeekComplete }
>> hda: dma error: error=0x00
>> cdrom_newpc_intr: 4 residual after xfer
>> cdrom_newpc_intr: 4 residual after xfer
>>
>> And hdparm shows the drive to no longer have DMA turned on, which it did
>> before running growisofs.
>>
>> The same command on a B&W G3 runs fine with DMA (2.4.23 kernel).
>>
>> So, to answer your question, it seems it does not work, no.
>
> Look like an underrun again, or an alignement problem as there
> seem to be something weird with the DBDMA on the G5 at least
> (there is some "workaround" code in darwin that I haven't been
> able to understand fully yet).

Ok, I'll just sit tight and wait a bit then. :)

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
