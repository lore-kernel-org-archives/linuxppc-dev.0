Date: Tue, 10 Oct 2000 12:08:34 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in the Delay loop
In-Reply-To: <39E294F4.E3FD24DB@mvista.com>
Message-ID: <Pine.HPX.4.10.10010101011400.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 10 Oct 2000, Dan Malek wrote:

>
> clark@esteem.com wrote:
>
> >         Does anybody know why a machine would hang in the Calibration Delay
> > Loop just before it spits out the BogoMIPs rating.
>
> This happens if the decrementer isn't running.  Is this an 8xx or 8260?
> They both have the ability to disable the timebase, which includes the
> decrementer (other processors don't do this).  An ICE often does more
> than you know, which could be an unexpected register setting that causes
> this to happen.

Hmmm..., actually all processors have a TBEN pin (except the 601) and many
chipsets have a register which is designed to control this. This would be
very useful to synchronize timebases on SMP systems, the problem is to
write support code for all platforms (is there a way to control this pin
on SMP G4).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
