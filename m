Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A91E6B7BD9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 21:50:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7LBkEEJ013279
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 05:46:14 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7LBntUe226446
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 05:49:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7LBntAT018614
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2009 05:49:55 -0600
Date: Fri, 21 Aug 2009 07:49:51 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: [PATCH 2/2] powerpc/405ex: support cuImage via included dtb
Message-ID: <20090821114951.GI2530@zod.rchland.ibm.com>
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<1250562484-16415-3-git-send-email-tiejun.chen@windriver.com>
	<20090820133118.GF2530@zod.rchland.ibm.com>
	<4A8E3396.9030006@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A8E3396.9030006@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 21, 2009 at 01:41:42PM +0800, tiejun.chen wrote:
>Josh Boyer wrote:
>> On Tue, Aug 18, 2009 at 10:28:04AM +0800, Tiejun Chen wrote:
>>> To support cuImage, we need to initialize the required sections and 
>>> ensure that it is built.
>>>
>>> -		cuboot-acadia.c cuboot-amigaone.c
>>> +		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c
>>> src-boot := $(src-wlib) $(src-plat) empty.c
>>>
>>> src-boot := $(addprefix $(obj)/, $(src-boot))
>>> @@ -192,6 +192,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
>>> image-$(CONFIG_EP405)			+= dtbImage.ep405
>>> image-$(CONFIG_WALNUT)			+= treeImage.walnut
>>> image-$(CONFIG_ACADIA)			+= cuImage.acadia
>>> +image-$(CONFIG_KILAUEA)		+= cuImage.kilauea
>> 
>> I'm not thrilled with this part as cuImage is really the secondary
>> solution if the U-Boot that comes with a board if FDT aware.  If you
>> have a different board that needs this, perhaps you could add the
>> target when that board support gets upstream?
>> 
>
>Agreed and I will remove this line as you expect. Right?

Yep, that sounds right.

josh
