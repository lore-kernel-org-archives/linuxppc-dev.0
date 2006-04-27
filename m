Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 78463679FD
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 21:53:15 +1000 (EST)
Date: Thu, 27 Apr 2006 13:43:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 04/16] ehca: userspace support
Message-ID: <20060427114355.GB32127@wohnheim.fh-wedel.de>
References: <4450A176.9000008@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4450A176.9000008@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

More minors.

On Thu, 27 April 2006 12:48:22 +0200, Heiko J Schick wrote:
> +
> +	EDEB_EN(7,
> +		"vm_start=%lx vm_end=%lx vm_page_prot=%lx vm_fileoff=%lx "
> +		"address=%lx",
> +		vma->vm_start, vma->vm_end, vma->vm_page_prot, fileoffset,
> +		address);

Gesundheit!  Seriously, I suspect "EDEB_EN" is not the best possible
name to pick.

> +                if (cq->ownpid!=cur_pid) {

Coding style would require spaces around binary operators.

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
