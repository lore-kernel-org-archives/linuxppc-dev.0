Return-Path: <rsmith@imagemap.com>
Received: from fileserver3.imagemap.com (mail.imagemap.com [68.156.94.66])
	by ozlabs.org (Postfix) with ESMTP id 6746667BEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 22:37:39 +1000 (EST)
Received: from amavis by fileserver3.imagemap.com with scanned-ok (Exim 3.36
	#1 (Debian)) id 1FTedr-0003Zs-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Apr 2006 08:40:15 -0400
Received: from fileserver3.imagemap.com ([127.0.0.1])
	by localhost (fileserver3 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13631-03 for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 08:40:03 -0400 (EDT)
Received: from [192.168.0.196] (helo=[192.168.0.196])
	by fileserver3.imagemap.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FTedf-0003Zm-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Apr 2006 08:40:03 -0400
Message-ID: <443CF3F8.408@imagemap.com>
Date: Wed, 12 Apr 2006 08:35:04 -0400
From: Randy Smith <rsmith@imagemap.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: root file system mounted via NFS - retry?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a general question regarding having a root file system mounted 
via NFS.  Our system consists of a linux PC that acts as the NFS server 
and two embedded ppc boards running linux that mount their file systems 
via NFS.  The problem is that the embedded boards boot much faster than 
the PC, and when they attempt to mount the root file system, the NFS 
server is not up yet.  The embedded boards hang and it takes quite a 
long time before the watchdog timer reboots them.  The next time round, 
they come up just fine.
What I would like for them to do is keep trying until the NFS server 
appears and then continue to boot.

We are running DENX's ELDK 2.4.25 kernel on the ppc boards and I know 
that for some linux releases, one may add values for timeo and retrans 
on the boot command line in the NFSROOT= command.  Can anyone tell me if 
they are valid for this release of the kernel?  Or if there is another 
way to accomplish this?

Thanks,

-Randy Smith
Software Engineer
ImageMap, Inc.
