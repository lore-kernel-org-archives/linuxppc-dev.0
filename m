Message-ID: <3BB0A5EA.A8F7392D@mvista.com>
Date: Tue, 25 Sep 2001 10:42:34 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Grant Erickson <erick205@umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Solutions for Fast Software Upgrade in Linux/PPC
References: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Erickson wrote:
>
> I am embarking on a project in which there exists a requirement to take my
> embedded system (Walnut board w/ PowerPC 405GP w/ raft of PCI devices) and
> allow it to perform a near-zero downtime upgrade/downgrade of
> software/firmware.
>
> Of the belief that there are very few new problems, just solutions that
> aren't widely known, I have to imagine that the telecommunications carrier
> equipment people have solved this problem long ago--albeit probably not
> with Linux.
>
> Does anyone know of any commercial or public solutions addressing this
> problem in Linux or Linux on the PowerPC?
>
> Anyway, there are a few solution spaces I can envision:
>
> 1. Check point all of your driver and application state, reboot, and
>    hope that you can warm-start with your check pointed state quickly.
>
>    - This means massaging the boot code, the Linux kernel, the device
>      drivers, and the applications to tweak their start-up time.
>
>    - At best, you may just quell kernel printks and disable auto-boot
>      countdown in the PROM, at most, buying you a few seconds, if that. If
>      it's a few seconds out of five, great. If it's a few out of twenty,
>      you've got a lot of work to do--maybe you'll get there...maybe not.

One note.. this has been discussed a lot on the linux kernel mailing
list (well a lot in the past at least.)  If all you will be doing is
maintaining the SAME kernel version till the end of time, and not
changing "critical" datastructures this "upgrade in place" can work.
However, even when moving minor versions of the kernel internal data
structures can change you you run into massive problems...  I would
suggest you scan the linux kernel mailing list (in addition to whatever
someone on this list suggests of course.)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
