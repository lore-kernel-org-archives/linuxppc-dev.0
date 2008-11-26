Return-Path: <spamreceptor@yahoo.com>
Received: from web30102.mail.mud.yahoo.com (web30102.mail.mud.yahoo.com
	[209.191.69.34]) by ozlabs.org (Postfix) with SMTP id BF6BEDDDDF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Nov 2008 09:20:38 +1100 (EST)
Date: Wed, 26 Nov 2008 14:20:36 -0800 (PST)
From: Joe Shmo <spamreceptor@yahoo.com>
Subject: Re: MPC8313erdb uboot1.3.0 kernel2.6.21 dp83848 NFS problem
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <160205.63568.qm@web30102.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was missing a little bit from my log.  Here's the
NFS failure:

portmap: server 192.168.1.21 not responding, timed out
Root-NFS: Unable to get nfsd port number from server,
using default
Looking up port of RPC 100005/1 on 192.168.1.21
portmap: server 192.168.1.21 not responding, timed out
Root-NFS: Unable to get mountd port number from
server, using default
mount: server 192.168.1.21 not responding, timed out
Root-NFS: Server returned error -5 while mounting
/home/developer/export
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "nfs" or
unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(2,0)
Rebooting in 180 seconds..



      
