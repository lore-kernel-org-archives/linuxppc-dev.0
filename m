Date: Fri, 29 Dec 2000 01:03:16 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: Cal Erickson <cal_erickson@mvista.com>
cc: Navin Boppuri <nboppuri@trinetcommunication.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Neighbour Table Overflow on NFS Server
In-Reply-To: <3A4BB95A.2F467DA3@mvista.com>
Message-ID: <Pine.LNX.3.96.1001229010201.1702B-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I may be completely off-base here, but I seem to recall getting some of
these a long time ago.  At the time I think it was cause by a lack of a
loopback device and routes.

-Mark

On Thu, 28 Dec 2000, Cal Erickson wrote:

>
> Navin,
>  The message "neighbour table overflow" is the result of some
> changes to the IP stack software in Linux version 2.2.x +. This
> simply means that you are unable to connect to your NFS
> server.  It may be related to the driver, but it may also be
> related to other issues, such as NFS server not running or
> incorrectly installed, no physical connectivity to NFS server,
> etc.  Check the configuration of your NFS server and IP
> network before diving into the driver.
>
> Cal Erickson
>
> Navin Boppuri wrote:
>
> > Hello,
> >
> > I have been debugging my custom 823 board. I have an NFS Server setup on
> > which my kernel on the board mounts. I have using this server without any
> > problems for more than a month. All of the sudden, my NFS Server complains
> > of "Neighbour Table overflow" . The NFS Server was not modified, nor
> > restarted. The error also says that the Server returned error -5.  Can
> > someone suggest any remedy for this problem?
> >
> > Sincerely,
> > Navin Boppuri
> >
>
> --
> ===========================================================================
> Cal Erickson                 MontaVista Software Inc.
> Linux Consultant             1237 E. Arques Ave.
> Phone (408) 328-0304         Sunnyvale CA 94085
> Fax   (408) 328-9204         web http://www.mvista.com
> ===========================================================================
>
>
>


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
