Message-ID: <39D8F728.C475B3C1@snmc.com>
Date: Mon, 02 Oct 2000 15:59:20 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Pravin Pathak <pkpathak@dnrc.bell-labs.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: adding n/w device
References: <39D8F043.BE8D511D@dnrc.bell-labs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pravin,

Yes, you can certainly add a network (n/w?) device in a running Linux
system.  We do it all the time.  Use the "ifconfig" command to bring
"up"
and interface and assign it an IP address, and even a MAC address.

Regards,
Daris Nevil


Pravin Pathak wrote:
>
> Hi
> It is general Linux question. Is it possible to add n/w device in a
> running Linux system ?
> Pravin
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
