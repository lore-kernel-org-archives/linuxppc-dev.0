Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C182B6F10
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Dec 2009 02:51:11 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBBFgcEv003910
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 10:42:38 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBBFp852103594
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 10:51:08 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBBFp7lA015127
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 08:51:08 -0700
Date: Fri, 11 Dec 2009 10:51:04 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 2/2 v4] powerpc/44x: Extend Katmai dts for ADMA and
	RAID56 support
Message-ID: <20091211155104.GB8458@zod.rchland.ibm.com>
References: <1260538793-6655-1-git-send-email-agust@denx.de>
	<1260538793-6655-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1260538793-6655-2-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, Yuri Tikhonov <yur@emcraft.com>,
	linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org,
	dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 11, 2009 at 02:39:53PM +0100, Anatolij Gustschin wrote:
>Add nodes for PPC440SPe DMA, I2O, XOR engines and Memory
>Queue module which are used in the updated PPC440SPe ADMA
>driver. Also extend plb ranges property to specify address
>ranges for DMA0/1 and I2O engines.
>
>Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>Signed-off-by: Anatolij Gustschin <agust@denx.de>

I've queued this up in my next branch.  I'll probably send this to Ben in the
next few days as the DTS changes are pretty independent of the actual driver.

josh
