Message-ID: <3CB773B7.657288AB@mvista.com>
Date: Fri, 12 Apr 2002 16:54:31 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Jer_57 <jer_57@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dhcpd/bootp and 405 (walnut)
References: <184-1503797947.20020412145158@cox.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jer_57 wrote:
> [root@vail root]# rpm -qa |grep dhcp
> dhcp-2.0pl5-8

I believe that the problem is that OpenBIOS is doing a DHCP request
directed to a specific IP, but the response that that particular
dhcpd does is to a broadcast address instead of directed back to the
IP that sent it.  You can verify that using tcpdump or ethereal.

This is fixed in the 2.0pl5 available from isc.org, but the 2.0pl5
in RH7.2 seems to be broken in this regards.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
