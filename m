Message-Id: <5.1.0.14.2.20030616234808.02ddad50@mail.ebshome.net>
Date: Mon, 16 Jun 2003 23:58:54 -0700
To: Marius Groeger <mag@sysgo.de>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: lowlat & preeempt
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.56.0306170732170.1316@mag.devdep.sysgo.de>
References: <3EEE93C5.4090302@tait.co.nz>
 <3EEE93C5.4090302@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:34 PM 6/16/2003, Marius Groeger wrote:

>On Tue, 17 Jun 2003, Robin Gilks wrote:
>
> > With the recent release of 2.4.21 I see many patches have been swept up
> > and incorporated. No sign of the low latency & preemption patches though
> > (not really suprising in a stable series) but does anyone have a set of
> > patches for this new tree for ppc only?
>
>The low latency patch is now part of the kpreempt patch. A kpreempt
>patch for 2.4.21-pre1 can be found here:
>
>http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

Are you sure?

preempt-kernel-rml-2.4.21-pre1-1.patch doesn't have
  - low latency stuff (http://www.zip.com.au/~akpm/linux/schedlat.html)
or
  - lock-breaking stuff
(http://www.kernel.org/pub/linux/kernel/people/rml/lock-break/)

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
