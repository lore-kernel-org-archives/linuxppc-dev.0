Date: Fri, 4 Aug 2000 15:45:50 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: Nelson Abramson <pogtal@erols.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
In-Reply-To: <398AE7C3.F8936771@erols.com>
Message-ID: <Pine.SOL.4.10.10008041523001.26828-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, Nelson Abramson wrote:

> Henry Worth wrote:
>
> > <snip>
> > Using the ATAPI CD drivers there are underruns with significant
> > dropouts every couple of seconds. Various hdparms and cdparanoia
> > parms were tried with no significant change. These include various
>
> <snip>
>
> I had issues using the "cdparanoia 1- - | play - -t WAV" until I realized
> that cdparanaoia was trying to do on the fly error correcting, resulting
> in the pause every few seconds.  By using the "-Z" flag, which turned off
> the error correcting, I got excellent playback with no skips what-so-ever
> on my Pismo.
>

Thanks, that works great with both the atapi and ide-scsi interfaces.
The sector rates for atapi is 3x what it was before. I still think the
aiff format may sound a tad better, the wav format seems a little
thin in comparison. For aiff the command would be:

cdparanoia 1- -Z -f - | play - -t aiff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
