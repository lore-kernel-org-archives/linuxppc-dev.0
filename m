Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f197.google.com (mail-yx0-f197.google.com
	[209.85.210.197]) by ozlabs.org (Postfix) with ESMTP id 3199BB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 03:24:27 +1100 (EST)
Received: by yxe35 with SMTP id 35so1261549yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 09:24:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BA24DA8.9030309@scram.de>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
	<4BA24DA8.9030309@scram.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 10:24:05 -0600
Message-ID: <fa686aa41003180924x1b6de684w7267013afd07496@mail.gmail.com>
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node to
	get node pointer
To: Jochen Friedrich <jochen@scram.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 18, 2010 at 9:58 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Grant,
>
>> The following structure elements duplicate the information in
>> 'struct device.of_node' and so are being eliminated. =A0This patches
>> makes all readers of the following elements use device.of_node instead.
>>
>> struct dev_archdata.prom_node (sparc)
>> struct dev_archdata.of_node (powerpc)
>> struct of_device.node
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> =A0drivers/i2c/busses/i2c-ibm_iic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
4 ++--
>> =A0drivers/i2c/busses/i2c-mpc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 17 ++++++++-------
>
> drivers/i2c/busses/i2c-cpm.c is missing in this patch.

Good catch, Thanks.

g.
