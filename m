Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8AA2FDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 21:44:25 +1100 (EST)
Message-ID: <45CAFEF0.6020408@cambridgebroadband.com>
Date: Thu, 08 Feb 2007 10:44:00 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: multiple devices using ELDK NFS mounts
References: <loom.20070208T072135-902@post.gmane.org>
In-Reply-To: <loom.20070208T072135-902@post.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Ng wrote:
> Hi,
> 
> I am working on multiple ELDK devices. So far, I just have one copy of the ELDK 
> NFS mount per device. This gets unwieldly when we have more than a few devices, 
> especially considering the size of one NFS mount being over 800Mb. 
> 
> Can you suggest a more efficient way? Something like sharing part of a single 
> NFS mount across multiple devices? Or some other way?
> 
> Cheers,
> Daniel
> 

I assume you are mounting the NFS as the *root* filesystem, and you don't want the
devices to overwrite eachothers files.

Why not build a ramdisk root filesystem and boot that.  Then mount the NFS filesystem
somewhere else, e.g. /usr.  This is very well described in the ELDK wiki.

Alex
