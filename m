Date: Thu, 28 Sep 2000 20:23:55 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: R Shapiro <rshapiro@bbn.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
In-Reply-To: <14803.24024.683420.911271@esb.bbn.com>
Message-ID: <Pine.LNX.4.21.0009282015220.15193-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Sep 2000, R Shapiro wrote:

>
> Just to add one more data point (as if another were needed :).  I
> tried switching from BootX to miBoot on the rev. a beige g3 minitower.
> It boots fine but then can't run xf 4.0.1 at all, even with the fbdev
> driver and a single Screen/Device pair.  The symptom is the same as
> using ati drivers in a BootX boot: no errors in the log, no core file,
> just an endlessly ringing bell and a hosed linux that I have to
> three-finger reboot (I can't get to a console and or connect via ssh
> to shut it down cleanly).

  Probably a missmatch between the fbdev device and BusID, xfree
disables the device used by fbdev with bad results.

 Kostas

PS> Any ideas why writing to a disabled pci device in ppc crashes
the machine but not the x86 ones ? Is this something that can be fixed
in the kernel or an arch thing ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
