Return-Path: <sripathik@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCEA6B6EF0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 17:53:21 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id o7B7gKSw032262
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 13:12:20 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7B7rEBG3219572
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 13:23:14 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7B7rEfE029251
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 13:23:14 +0530
Date: Wed, 11 Aug 2010 13:23:13 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: kernel version 2.6.35-git10 build failure
Message-ID: <20100811132313.3d6c7f27@sripathi.in.ibm.com>
In-Reply-To: <4C624F7F.3070608@linux.vnet.ibm.com>
References: <4C624F7F.3070608@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 11 Aug 2010 12:51:35 +0530
divya <dipraksh@linux.vnet.ibm.com> wrote:

> Hi,
> 
> Today kernel(version 2.6.35-git10 -commitid 3d30701b58970) build fails with following error on both system x and p
> 
>    fs/9p/vfs_inode.c: In function 'v9fs_vfs_setattr_dotl':
>    fs/9p/vfs_inode.c:1267: error: implicit declaration of function 'inode_setattr'
>    make[2]: *** [fs/9p/vfs_inode.o] Error 1
>    make[2]: *** Waiting for unfinished jobs....
>    make[1]: *** [fs/9p] Error 2
>    make[1]: *** Waiting for unfinished jobs....
>    make: *** [fs] Error 2
>    make: *** Waiting for unfinished jobs....
> 
> Seems like the commit 87d7845aa0b is the corrupt which added the function v9fs_vfs_setattr_dotl()

Yes, it is a problem I created. Stephen Rothwell has already fixed it.
Al Viro has sent a git pull request to Linus today with the fix in it.
Here is the patch you need: http://lkml.org/lkml/2010/6/21/442

Thanks,
Sripathi.

> 
> Thanks
> Divya
> 
> 
