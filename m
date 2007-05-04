Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE149DDED0
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 03:27:50 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l44HRjQZ093522
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 17:27:45 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l44HRj3X2306218
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 18:27:45 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l44HRje0000485
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 18:27:45 +0100
Received: from [9.152.237.39] (dyn-9-152-237-39.boeblingen.de.ibm.com
	[9.152.237.39])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l44HRjeB000473
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 18:27:45 +0100
Message-ID: <463B6D0F.2040509@linux.vnet.ibm.com>
Date: Fri, 04 May 2007 19:27:43 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: BUG: spufs_prune_dir() / spufs_fill_dir() error handling
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If d_alloc_name() fails in spufs_fill_dir() spufs_prune_dir(dir) gets
called. dir->inode is still NULL and used.

Sebastian
