Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [194.196.100.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13CE0B7D27
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 00:30:36 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id o2CDUR9L030167
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 13:30:27 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o2CDURJr839872
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 13:30:27 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o2CDUP9R004020
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 13:30:26 GMT
Date: Fri, 12 Mar 2010 14:30:22 +0100
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 25/37] drivers/infiniband: use .dev.of_node instead of
	.node in struct of_device
Message-ID: <20100312143022.18b954a5@alex-laptop>
In-Reply-To: <adavdd2d41q.fsf@roland-alpha.cisco.com>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180605.4824.3613.stgit@angua>
	<adavdd2d41q.fsf@roland-alpha.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	linuxppc-dev@ozlabs.org, James.Bottomley@suse.de,
	linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org,
	jeremy.kerr@canonical.com, sfr@canb.auug.org.au,
	linux-scsi@vger.kernel.org, jgarzik@pobox.com,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, ben-linux@fluff.org,
	monstr@monstr.eu, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 Mar 2010 11:57:53 -0800
Roland Dreier <rdreier@cisco.com> wrote:

> Seems fine... adding EHCA guys just to make sure.
> 
>  > .node is being removed
>  > 
>  > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Alexander Schmidt <alexs@linux.vnet.ibm.com>
