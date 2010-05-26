Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1262B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 May 2010 21:50:53 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4QBiJgt028688
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 May 2010 05:44:19 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4QBodof026268
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 May 2010 05:50:41 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4QBrZE6013290
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 May 2010 05:53:35 -0600
Date: Wed, 26 May 2010 07:50:37 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv2] [RFC] Xilinx Virtex 4 FX Soft FPU support
Message-ID: <20100526115037.GI24511@zod.rchland.ibm.com>
References: <201005201401.09912.temerkhanov@cifronik.ru>
	<AANLkTimJUqD6n9LHGZcWEkHFKvSRJsHJ9gQYMNBsIBu1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimJUqD6n9LHGZcWEkHFKvSRJsHJ9gQYMNBsIBu1@mail.gmail.com>
Cc: Sergey Temerkhanov <temerkhanov@cifronik.ru>, linuxppc-dev@lists.ozlabs.org,
	John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 25, 2010 at 03:38:47PM -0600, Grant Likely wrote:
>Hmmm.  There should be a nicer way of doing this, but this will do for now.
>
>Otherwise, this patch looks good to me.  Josh, what do you think?

I don't have any additional comments.  I agree with Grant on the points he
raised, and otherwise it also looks good to me.

josh
