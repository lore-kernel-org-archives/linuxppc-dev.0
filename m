Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id E6B6ADDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Nov 2008 13:56:51 +1100 (EST)
Message-ID: <492E0CCA.7020104@windriver.com>
Date: Thu, 27 Nov 2008 10:58:18 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Joe Shmo <spamreceptor@yahoo.com>
Subject: Re: MPC8313erdb uboot1.3.0 kernel2.6.21 dp83848 NFS problem
References: <160205.63568.qm@web30102.mail.mud.yahoo.com>
In-Reply-To: <160205.63568.qm@web30102.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8
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

Joe Shmo wrote:
> I was missing a little bit from my log.  Here's the
> NFS failure:
> 
> portmap: server 192.168.1.21 not responding, timed out
> Root-NFS: Unable to get nfsd port number from server,
> using default
> Looking up port of RPC 100005/1 on 192.168.1.21
> portmap: server 192.168.1.21 not responding, timed out
> Root-NFS: Unable to get mountd port number from
> server, using default
> mount: server 192.168.1.21 not responding, timed out
> Root-NFS: Server returned error -5 while mounting
> /home/developer/export
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or
> unknown-block(2,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(2,0)
> Rebooting in 180 seconds..
> 
> 

Let us supposed your local network environment configuration is matched and
correct. I think you can boot kernel with Ramdisk firstly. Then under the shell
prompt you up (or mount another fs with NFS) your NIC and you also use the
tcpdump to snoop the detailed network message to track something.

Tiejun

> 
>       
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
