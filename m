Message-ID: <395722C9.8510A7EE@student.ethz.ch>
Date: Mon, 26 Jun 2000 11:30:49 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi-experts needed: target aborted
References: <00062523582400.00479@lobo.localnet>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Haeuptli wrote:

> I was never able to access my scanner (UMAX astra 1200S, scsi).
>
> mesh reports: target 6 aborted, interrupt in idle phase ?
>
> Some time ago, somebody posted a patch (see end of message) to enable
> scsi-debugging, which miraculously makes the scanner get recognized by the
> kernel and work (partly) with SANE...
> I had to disabled the patch again, because my log file (and the console) got
> filled up with tons of debug infos.
>
> Now my question to scsi-cracks:
> Why does the device only gets registered with debugging enabled (no other
> changes to mesh)

I'm not a SCSI crack, but anyway :)

Debugging slows down very much, so - sounds to me like the SCSI driver needs
idle loops and/or memory barriers here and there...


Michel


--
No gates, no windows ... It's open!
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
