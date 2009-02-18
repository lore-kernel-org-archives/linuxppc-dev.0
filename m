Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id C7CF7DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 05:20:27 +1100 (EST)
Message-ID: <499C4DD7.9000007@am.sony.com>
Date: Wed, 18 Feb 2009 10:05:11 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: gt bradley <baykelper@yahoo.com>
Subject: Re: NFS-boot on PS3, kboot can't mount nfs-dir.s
References: <5708.94078.qm@web56204.mail.re3.yahoo.com>
In-Reply-To: <5708.94078.qm@web56204.mail.re3.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/17/2009 03:14 PM, gt bradley wrote:
> I'm trying to set up my PS3 to netboot (with an nfsroot).
> 
> I'm using instructions at
> http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-howto/ps3-nfs-root-howto.txt
> 
> I've passed section 3 (using tftp) to verify network /dhcp etc.   (i.e.
> I'm able to tftp-get a file to ps3 from kboot's ash shell (busybox).
> 
> i'm trying to mount the nfs server as per section 4. with
> 
>  ~# mount -t nfs -o nolock 192.168.99.1:/target /mnt/remote
> 
> I get the following error message:
>   mount: mounting 192.168.99.1:/target on /mnt/remote failed
> 
> if I boot the PS3 from the HD, then I am able to mount the nfs directory.
> Using wireshark, I can see the initial dhcp traffic, (and when present the tftp traffic).
> the mount command doesn't open a network connection to the server, 
> So I have pretty much ruled out server
>  configuration.
> 
> running "strings" on the decompressed kboot image yeilds serveral nfs symbols, so it 
> appears to still support nfs mounting.  (using version kboot-20080609.bld from geoff's dir at kernel.org)
> 
> I have tried googling, and searching the various mailing lists, but am
> stuck.
> 
> any help would be appreciated
> GT

Please see my reply to the almost identical post that was sent yesterday (Feb 16).

-Geoff 
