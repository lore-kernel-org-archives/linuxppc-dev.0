Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02CCF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 04:57:08 +1000 (EST)
Received: from mail219-va3 (localhost [127.0.0.1])	by
 mail219-va3-R.bigfish.com (Postfix) with ESMTP id 579D3600231	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 18:57:03 +0000 (UTC)
Received: from VA3EHSMHS038.bigfish.com (unknown [10.7.14.242])	by
 mail219-va3.bigfish.com (Postfix) with ESMTP id 036C97E016B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 18:56:50 +0000 (UTC)
Date: Wed, 26 Jun 2013 13:56:45 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc/85xx: Move ePAPR paravirt initialization earlier
To: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
In-Reply-To: <51CAE047.8030605@freescale.com> (from
 Laurentiu.Tudor@freescale.com on Wed Jun 26 07:36:23 2013)
Message-ID: <1372273005.8183.32@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2013 07:36:23 AM, Tudor Laurentiu wrote:
> On 06/26/2013 02:14 AM, Scott Wood wrote:
>> This would require converting
>> the code to use the early device tree functions.
>>=20
>=20
> I see. Had a look at that api and it seems pretty limited.
> I couldn't find a simple way of reading a property other than =20
> scanning the entire tree with of_scan_flat_dt().

What's wrong with scanning the entire tree?  The data format doesn't =20
allow any more efficient type of lookup (it was designed to be simple =20
and small, not fast).

-Scott=
