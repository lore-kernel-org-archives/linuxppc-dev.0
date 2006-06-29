Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8B98667B54
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 16:38:08 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5T6c7EC015182
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 23:38:07 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5T6c516008071
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 01:38:06 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E1A052@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: RE: patches applied to powerpc.git
Date: Thu, 29 Jun 2006 14:38:04 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, linux-kernel-owner@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> Zang Roy-r61911 writes:
> 
> > 	I have submitted the "v2" version for mpc7448hpc2 board 
> support in arch/powerpc/platforms/embedded6xx.
> > 	I  have not got any suggestion, since I submitted the code.
> > 	In this submission I have addressed all the issues 
> brought up in the "v1" submission. 
> > 	So could you help me merge the patches into your git 
> tree ? If there is any comment about the code, please let me know.
> 
> I have taken 1, 2, and 4.  Ben H asked me to delay with patch 
> 3/4 because it will conflict with changes he is making.  Also 
> I would like to see it done in a fashion which doesn't add 
> two extra loads to things like _mpic_ipi_read etc.
> 
> Paul.
> 
Paul
	Great news!
	For tsi108 mpic part, it is a bit complex:). We can wait for
Ben's code to decide the direction of our mpic.
	
Ben, 
	Where is your patch? So many guys wait for it!

Roy
	
