Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09805DDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 02:00:50 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n05ExKri001319
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 07:59:21 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n05F0eH7133488
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 08:00:40 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n05F0dCO019986
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 08:00:40 -0700
Date: Mon, 5 Jan 2009 10:00:25 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Copy bootable images in the default install
	script
Message-ID: <20090105150025.GA26783@zod.rchland.ibm.com>
References: <20081220005720.23861.18505.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081220005720.23861.18505.stgit@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>,
	LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 19, 2008 at 05:57:20PM -0700, Grant Likely wrote:
>From: Grant Likely <grant.likely@secretlab.ca>
>
>This patch makes the default install script (arch/powerpc/boot/install.sh)
>copy the bootable image files into the install directory.  Before this
>patch only the vmlinux image file was copied.

What do you do for cases where there isn't a single file?  E.g. a 
canyonlands board will need both the uImage and caynonlands.dtb files
to be "installed".  U-Boot needs to be provided with both of them.

josh
