MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: remote access via shell
Date: Tue, 9 Mar 2004 07:26:59 -0700
Message-ID: <8039970AF146314597457D3B51A68B388F36D4@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are probably running busybox (or should be).  Busybox includes a telnetd telnet daemon.
  http://www.busybox.net/

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Kevin P.
> Dankwardt
> Sent: Tuesday, March 09, 2004 9:21 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: remote access via shell
>
>
>
> I have a ppc 5100 that is currently running Linux. I also
> have downloaded
> and looked at the ELDK. Neither appear to have a telnet nor a
> ssh daemon.
> What daemon for remote access is recommended? Are there small versions
> especially appropriate for embedded use? Versions that have Make files
> conducive to cross-compilation for PPC?
>
> Thanks,
> Kevin Dankwardt
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
