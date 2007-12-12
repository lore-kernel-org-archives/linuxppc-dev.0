Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F67CDDF63
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 03:01:41 +1100 (EST)
Message-Id: <49C1603C-F3A4-4AE6-8658-96C9231C460C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <475FFBA3.9080607@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
Date: Wed, 12 Dec 2007 10:01:22 -0600
References: <11970422334145-git-send-email-timur@freescale.com>
	<475FFBA3.9080607@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2007, at 9:17 AM, Timur Tabi wrote:

> Timur Tabi wrote:
>> Define the layout of a binary blob that contains a QE firmware and  
>> instructions
>> on how to upload it.  Add function qe_upload_firmware() to parse  
>> the blob
>> and perform the actual upload.  Fully define 'struct rsp' in  
>> immap_qe.h to
>> include the actual RISC Special Registers.  Added description of a  
>> new
>> QE firmware node to booting-without-of.txt.
>
> If there are no objections, I'd like this patch to be pulled into  
> for-2.6.25. Thanks.

I'm just waiting for you to hit v99 :)

- k
