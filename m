Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE002.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 88A64DDDA9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 11:31:19 +1100 (EST)
Message-ID: <499B56CE.1050505@am.sony.com>
Date: Tue, 17 Feb 2009 16:31:10 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: gt bradley <baykelper@yahoo.com>
Subject: Re: nfs booting PS3, mount failed.
References: <719599.32884.qm@web56204.mail.re3.yahoo.com>
	<499B544D.3020704@am.sony.com>
In-Reply-To: <499B544D.3020704@am.sony.com>
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

On 02/17/2009 04:20 PM, Geoff Levand wrote:

> Another thing to try is to use a 'rescue' disk/mode to copy the files.
> Most distros have them.  Fedora has a rescue mode in their installer:
> 
>   http://download.fedora.redhat.com/pub/fedora/linux/releases/10/Fedora/ppc/iso/Fedora-10-ppc-netinst.iso
> 
> Just select 'rescue' instead of 'install', or you can add
> these to the boot options: 'text rescue video=720p'.

I forgot to mention an important point when using a rescue disk.
Most will mount all the runtime directories like /sys, /dev, /proc,
etc. onto the HD file system.  Those directories should not be
mounted the when you make the HD root FS copy.

Either choose the rescue option to not mount the HD file system,
and mount it yourself later, or unmount all those directories.
Just use the 'mount' command to see what has been mounted on the
HD's root FS.

-Geoff
