Message-ID: <39E2059E.3FD5CE7D@mvista.com>
Date: Mon, 09 Oct 2000 10:51:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot over NFS
References: <39DCEA5A.2E9DDE3C@emc.com> <14813.60363.648514.72914@igor.jsc.nasa.gov> <39DFE65C.8FEAB6B5@emc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhaobin Zhu wrote:

> Hi,
>
> Did anybody successfully boot Hardhat linux
> over NFS on sandpoint ?

Yes, I have many times.

Make sure you have the proper selection in make menuconfig...
- go into Networking options and make sure TCP/IP networking/IP: kernel level
autoconfiguration/IP: BOOTP support is selected
- make sure the driver for your network card is selected
- go into File systems/Network File Systems and make sure NFS file system
support/Root file system on NFS is selected

This should at least get you closer.



> Did anybody try to do this following steps
> instructed in Hardhat CDK1.2 manual ?

The instructions in the manual should work.  If they don't work for you (and
you're SURE that your kernel is configured correctly) please email
support@mvista.com and let them know.

> Is it possible to boot linux on Sandpoint over NFS on an isolated
> (The only network connection is between PC and Sandpoint) redhat PC ?
>

Yes as long as your network is connected correctly and your PC is configured
correctly.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
