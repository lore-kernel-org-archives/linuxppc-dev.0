Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9EE73B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 01:03:10 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p04DkBj5023417
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 08:46:12 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AD7D94DE8046
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 09:00:18 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p04E35jV181060
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 09:03:05 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p04E7SBo007046
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jan 2011 07:07:28 -0700
Date: Tue, 4 Jan 2011 09:01:58 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/405: Fix missing #{address,size}-cells in i2c node
Message-ID: <20110104140158.GB2364@zod.rchland.ibm.com>
References: <20110103220520.9355.2745.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110103220520.9355.2745.stgit@localhost6.localdomain6>
Cc: linuxppc-dev@lists.ozlabs.org, solomon@linux-wlan.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 03, 2011 at 03:06:03PM -0700, Grant Likely wrote:
>Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>---
>
>I'm putting this patch into my next-devicetree branch.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
