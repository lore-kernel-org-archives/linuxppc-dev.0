Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4C6C67C39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 17:03:58 +1100 (EST)
Message-ID: <455AACE1.1080300@dlasys.net>
Date: Wed, 15 Nov 2006 01:00:01 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: embedded ppc rootfs?
References: <F6E84D87-6208-4A94-88D6-2947FDBE8927@kernel.crashing.org>
In-Reply-To: <F6E84D87-6208-4A94-88D6-2947FDBE8927@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded \(\(\(\(E-Mail\)\)\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I was wondering what people are using for their projects as  
> "distro's" for their root file systems.  I spent this weekend trying  
> to get several of the alternatives I could find working on a ppc64  
> host system with out much success.
>
> I'm interested in two aspects of this question.  One, are their  
> projects that I missed that people are using on ppc (eldk, buildroot,  
> lfs, ltib).  Two, is there an need for a better open source embedded  
> distro for ppc?  And if so, do people have the ability to pitch in  
> some effort towards producing a better distro?
>   
    I am booting to an intramfs. I used busybox for the basic tools. It 
is small and easy - the intramfs just merges into a single zImage.elf file.
    It is supposed to be embedded so I am not looking to provide a full 
development environment, just the minimum needed to run whatever
    Linux applications and services a client chooses for their embedded 
system.
    I do not need/want a Distro (I am not against Distro's,  but the key 
word is embedded).
    Soon we will likely do something like an fuse/sshfs mount to support 
a native embedded development environment.


> - kumar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
