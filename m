Return-Path: <chris@microtronix.com>
Received: from mercedes.microtronix.com (LONDON14-1168104083.sdsl.bell.ca
	[69.159.218.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59FABDDDED
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 09:08:16 +1100 (EST)
Message-ID: <4936FC3D.8080607@microtronix.com>
Date: Wed, 03 Dec 2008 16:38:05 -0500
From: Chris Craig <chris@microtronix.com>
MIME-Version: 1.0
To: mike zheng <mail4mz@gmail.com>
Subject: Re: Boot with NFS on MIPS32
References: <5c9cd53b0812031306r7dc848ccy1baecea50191f84b@mail.gmail.com>
In-Reply-To: <5c9cd53b0812031306r7dc848ccy1baecea50191f84b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I believe you need to enable "Kernel level autoconfiguration" which is 
under Networking->Networking support->Networking options->TCP/IP 
networking (IP_PNP), and then you'll have a "Root file system on NFS" 
option (ROOT_NFS) available under Network File Systems.

-- 
Chris Craig
Microtronix Datacom Ltd.
9-1510 Woodcock Street
London ON  N6H 5S1
Canada
Toll-Free: (888) 690-0091 x253 (NA only)
Phone:     (519) 690-0091 x253
http://microtronix.com



mike zheng wrote:
> Hi All,
> 
> I have one MIPS32 embedded system with Linux Kernel 2.6.23.17. Right
> now, I have problem to boot from NFS. The NFS server works fine. I am
> able to mount the directory from anther Linux work station. I attach
> the .config file, there maybe some config flags I forget to open.
> 
> Thanks for your help,
> 
> Mike
> 
> 
> Here is the kernel command line:
> ===========================
> Kernel command line: root=/dev/nfs rw
> nfsroot=47.1.1.108:/localdisk/rootfs/
> ip=47.1.1.2:47.1.1.1:255.255.255.0:Min-MIPS:eth0:off
> 
> Here is the error:
> ===========================
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> IPv6 over IPv4 tunneling driver
> sit0: Disabled Privacy Extensions
> NET: Registered protocol family 17
> 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> All bugs added by David S. Miller <davem@redhat.com>
> VFS: Cannot open root device "nfs" or unknown-block(0,255)
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,255)
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
