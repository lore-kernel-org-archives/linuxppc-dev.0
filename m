Message-Id: <200004261951.MAA04687@pop3.ucdavis.edu>
Date: Wed, 26 Apr 2000 12:51:25 -0700
Subject: Re: XFree 4.0 dual monitor on AGP G4
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: daenzerm@student.ethz.ch
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Unfortunately, the XFree86 4.0 docs say that PCI id's are mandatory for
>> dual-head configs.
>
> So? You have specified them.
>

Well using fbdev in principle should be abstracted from pci hardware.

>> Oh and it dies before it writes to the logfile. So I have no clue what to do
>> next. Suggestions?
>
> - remount (at least) the partition containing /var/log in sync mode (to get at
>   least something from the log)
>
> - run X with -probeonly
>
>
> Michel

given what Kostas Gewrgiou told me regarding the fbdev_open_pci function,
viewing logs isn't going to do me any good.

oh, and probeonly crashes the machine :-(

- Taylor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
