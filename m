Date: Sun, 17 Sep 2000 11:47:12 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: Gabriel Paubert <paubert@iram.es>
cc: Paul Mackerras <paulus@linuxcare.com.au>, linuxppc-dev@lists.linuxppc.org
Subject: dual G4 time issues..
In-Reply-To: <Pine.HPX.4.10.10008121339410.27028-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.21.0009171144200.26873-100000@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 12 Aug 2000, Gabriel Paubert wrote:

>
> On Sat, 12 Aug 2000, Paul Mackerras wrote:
>
> > Gabriel Paubert writes:
> >
> > > > Certainly on my 7600 with a 2-cpu powersurge board, with the code that
> > > > is currently in the devel kernel to use the tb register, you don't get
> > > > the same time on both cpus.
> > >
> > > Yes, we need a way to check that the timebase are in sync and to sync
> > > them if they are not. That's basically the same problem in any case.
> > > The problem is to do it in a way that works on all machines...
> >
> > Until we get SMP working on the 2-cpu G4 machines (hopefully I will be
> > getting one soon), the old powersurge board is the only supported SMP
> > powermac.  I found with mine that when you start the second CPU, it
> > stops the decrementers (and I expect timebases as well) on both CPUs
> > until you send an interrupt from the primary to the secondary cpu.

Benh and I are pushing Mac G4 SMP patches into the recently
created linuxppc_2_5 tree. It currently seems to work reasonably well,
except there is some work needing to be done on syncing the timebases on
CPU's. I seem to have about a 14 second difference between the 2 CPU's on
the machine I'm testing on now.

(from ping -f)

43505 packets transmitted, 43504 packets received, 0% packet loss
round-trip min/avg/max = -144657.0/0.1/144657.3 ms


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
