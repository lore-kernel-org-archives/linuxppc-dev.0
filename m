Message-ID: <3A4BB95A.2F467DA3@mvista.com>
Date: Thu, 28 Dec 2000 14:06:18 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Navin Boppuri <nboppuri@trinetcommunication.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Neighbour Table Overflow on NFS Server
References: <002f01c070de$15248760$4a1f76d8@washington>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin,
 The message "neighbour table overflow" is the result of some
changes to the IP stack software in Linux version 2.2.x +. This
simply means that you are unable to connect to your NFS
server.  It may be related to the driver, but it may also be
related to other issues, such as NFS server not running or
incorrectly installed, no physical connectivity to NFS server,
etc.  Check the configuration of your NFS server and IP
network before diving into the driver.

Cal Erickson

Navin Boppuri wrote:

> Hello,
>
> I have been debugging my custom 823 board. I have an NFS Server setup on
> which my kernel on the board mounts. I have using this server without any
> problems for more than a month. All of the sudden, my NFS Server complains
> of "Neighbour Table overflow" . The NFS Server was not modified, nor
> restarted. The error also says that the Server returned error -5.  Can
> someone suggest any remedy for this problem?
>
> Sincerely,
> Navin Boppuri
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
