Date: Sat, 4 Aug 2001 15:21:19 -0700 (MST)
From: Jeff Rugen <jprugen@earthlink.net>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bogus SCSI timeouts and ntpd...
In-Reply-To: <20010804121840.G17468@altus.drgw.net>
Message-ID: <Pine.LNX.4.21.0108041518010.11122-100000@raptor.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 4 Aug 2001, Troy Benjegerdes wrote:

>
> I have recently started getting what appear to be 'bogus' SCSI timeouts
> after a crash and reboot, when my raid1 is re-syncing. (which amounts to
> copying disk1 of the raid to disk2 of the raid.)
>
> This didn't start happening until I started running ntpd at bootup..
>
> I suspect something is broken somewhere such that when ntp adjusts the
> time by a small amount, the SCSI layer (and generic timer code??) gets
> confused and thinks that SCSI command have timed out.
>

<snip etc.>

I mailed the list a while ago about the ncr53c8xx SCSI driver hanging the
system with SCSI timeouts a while ago on a Motorola PowerStack with the
2.4.x kernels.  I am running xntpd at boot time.  I can (will) try
disabling it and seeing if a 2.4.x kernel stays up for a longer period of
time (typically less than 6 hours previously).

Jeff Rugen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
