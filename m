Return-Path: <hachti@hachti.de>
Received: from ente.hachti.de (ente.hachti.de [212.227.83.80])
	by ozlabs.org (Postfix) with ESMTP id 4FE58DDFC7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Aug 2008 10:50:44 +1000 (EST)
Message-ID: <48A22DB7.2090804@hachti.de>
Date: Wed, 13 Aug 2008 02:41:27 +0200
From: Philipp Hachtmann <hachti@hachti.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: ml507 initrd problem
References: <8BB04FAC749BD24BBA250E9D09F2F18B220ABB@MAIL-SJC.quantum3d.com>
In-Reply-To: <8BB04FAC749BD24BBA250E9D09F2F18B220ABB@MAIL-SJC.quantum3d.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Stu Bershtein <sbershtein@Quantum3D.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> *RAMDISK: Compressed image found at block 0*
> *VFS: Mounted root (ext2 filesystem).*
> *Freeing unused kernel memory: 144k init*
That looks normal.

> *open /dev/console*
> *fd 0*
> *code 10000000 - 1019854c, data 10195000 - 1019854c, stack bf85df00*
> *open /dev/null*
> *fd 3*
> *open /etc/inittab*
> *fd 3*
I don't know that stuff.

 > *And it gets very quiet at that point.  The kernel is still running in
 > ppc44x_idle.  Does this suggest anything to anyone?  I’ll be more than
 > happy to send or describe any config files to any one who might take 
pity.*

One question: What is in your /linuxrc? Do you have a shell in your 
initrd? What about booting into your shell with init=</path/to/shell>?


Regards,
Philipp


-- 
http://www.hachti.de
