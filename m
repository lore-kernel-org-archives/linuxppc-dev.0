Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A56C6B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 01:41:17 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB9ESeiN016905
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 07:28:40 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nB9EexJU250684
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 07:41:00 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB9Eev5N009626
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2009 07:40:57 -0700
Date: Wed, 9 Dec 2009 09:40:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: Increase warp SD buffer
Message-ID: <20091209144055.GS2937@zod.rchland.ibm.com>
References: <20091209000437.78794a8f@opus.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091209000437.78794a8f@opus.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 09, 2009 at 12:04:37AM -0500, Sean MacLennan wrote:
>Newer revs of the FPGA have a larger SD buffer.

How does that impact the older revisions?  You're using a cuImage with Warp,
so the device tree is bundled with that.  If you boot a new kernel with this
change to the DTS on a older board revision, will it do bad things?

josh
