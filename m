Date: Mon, 29 Jan 2001 15:54:35 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook doubles as a frying pan
Message-ID: <20010129155435.K15043@altus.drgw.net>
References: <200101280019.QAA15270@mail.turbolinux.com> <19341224043310.26390@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19341224043310.26390@mailhost.mipsys.com>; from benh@kernel.crashing.org on Mon, Jan 29, 2001 at 12:01:26PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 29, 2001 at 12:01:26PM +0100, Benjamin Herrenschmidt wrote:
>
> >
> >is everyone *totally* sure that activating the fan is entirely handled in
> >hardware? is there no
> >register for controlling the threshold?
>
> I've seen nothing in Apple's own Darwin OS related to controlling the
> powerbook fan neither. However, they do have code that use the CPU's
> temperature sensors to control the ICTC (instruction cache throttling).
>
> Troy have some code that allow to read the temp from /proc. However, it
> looks like a lot of CPUs are so badly calibrated that the information
> returned is almost useless... Maybe that's not the case in CPUs used in
> portables, that's the case in some of the G4s used in dual G4s.

The IBM manufactured 750's are much better in calibration than the G4's.
Brad, recent 2.4 kernels should have my 'CONFIG_TAU' config option to turn on
the CPU temp monitoring. This code is interrupt driven, so someone could
easily ad code to tweak the ICTC when the temp exceeds certain thresholds.

--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
