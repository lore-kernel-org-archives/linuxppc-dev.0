To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Trouble compiling kernel for G5.
References: <874qv5c9xd.fsf@hades.nocrew.org>
	<1073778255.17403.28.camel@gaston> <87llofbaok.fsf@hades.nocrew.org>
	<1073781366.17403.41.camel@gaston>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: Sun, 11 Jan 2004 02:16:51 +0100
In-Reply-To: <1073781366.17403.41.camel@gaston> (Benjamin Herrenschmidt's
 message of "Sun, 11 Jan 2004 11:36:06 +1100")
Message-ID: <87d69rb7y4.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2004-01-11 at 11:17, Stefan Berndtsson wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>
>> > On Sat, 2004-01-10 at 04:24, Stefan Berndtsson wrote:
>> >> When trying to compile the latest rsynced kernel (checked today, 2004-01-09)
>> >> from source.mvista.com::linuxppc-2.5-benh (2.6.1-rc1-ben1) for my G5, I
>> >> run into the following message with SATA:
>> >
>> > rsync again
>>
>> Figured from the other mails that mvista wasn't up to date at the point,
>> so with a 2.6.1-ben1 it compiled and booted fine. Thanks.
>>
>> Any news on when DVD-writing will be possible with DMA turned on?
>
> It doesn't work at the moment ?

When I, on the G5, run:

growisofs -Z /dev/hda -dvd-video dvddir

I get:

ide0, timeout waiting                   for dbdma command stop
ide-cd: dma error
hda: DMA disabled
hda: dma error: status=0x50 { DriveReady SeekComplete }
hda: dma error: error=0x00
cdrom_newpc_intr: 4 residual after xfer
cdrom_newpc_intr: 4 residual after xfer

And hdparm shows the drive to no longer have DMA turned on, which it did
before running growisofs.

The same command on a B&W G3 runs fine with DMA (2.4.23 kernel).

So, to answer your question, it seems it does not work, no.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
