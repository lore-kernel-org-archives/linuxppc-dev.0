Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC426B6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 17:21:38 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id o7B7LZE3015832
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 12:51:35 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7B7LYGa3764422
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 12:51:34 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7B7LY7O026239
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 17:21:34 +1000
Message-ID: <4C624F7F.3070608@linux.vnet.ibm.com>
Date: Wed, 11 Aug 2010 12:51:35 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	sripathik@in.ibm.com
Subject: kernel version 2.6.35-git10 build failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Today kernel(version 2.6.35-git10 -commitid 3d30701b58970) build fails with following error on both system x and p

   fs/9p/vfs_inode.c: In function 'v9fs_vfs_setattr_dotl':
   fs/9p/vfs_inode.c:1267: error: implicit declaration of function 'inode_setattr'
   make[2]: *** [fs/9p/vfs_inode.o] Error 1
   make[2]: *** Waiting for unfinished jobs....
   make[1]: *** [fs/9p] Error 2
   make[1]: *** Waiting for unfinished jobs....
   make: *** [fs] Error 2
   make: *** Waiting for unfinished jobs....

Seems like the commit 87d7845aa0b is the corrupt which added the function v9fs_vfs_setattr_dotl()

Thanks
Divya
