Return-Path: <B37400@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A2E72C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 20:50:02 +1000 (EST)
Received: from mail153-co1 (localhost [127.0.0.1])	by
 mail153-co1-R.bigfish.com (Postfix) with ESMTP id 1837F7C009A	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 10:49:57 +0000 (UTC)
Received: from CO1EHSMHS007.bigfish.com (unknown [10.243.78.246])	by
 mail153-co1.bigfish.com (Postfix) with ESMTP id 5570164003F	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 10:49:55 +0000 (UTC)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: RE: [2/3][PATCH][upstream] TDM Framework
Date: Thu, 26 Jul 2012 10:49:54 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E50F8C0@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
 <500EB47F.1040903@freescale.com>
In-Reply-To: <500EB47F.1040903@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Please find my comment inline.

Regards,
Sandeep


-----Original Message-----
From: Tabi Timur-B04825=20
Sent: Tuesday, July 24, 2012 8:13 PM
To: Singh Sandeep-B37400
Cc: linuxppc-dev@lists.ozlabs.org; Aggrwal Poonam-B10812
Subject: Re: [2/3][PATCH][upstream] TDM Framework

Singh Sandeep-B37400 wrote:

>> +int tdm_adap_send(struct tdm_adapter *adap, void **buf, int count) {
>> +       int res;
>> +
>> +       if (adap->algo->tdm_write)
>> +               res =3D adap->algo->tdm_write(adap, buf, count);
>=20
> Why does tdm_write() return a u32?  And shouldn't 'res' also be a u32, to=
 make tdm_write()?
> [Sandeep] tdm_write() returns number of bytes written. You are right,=20
> 'res' should be declared as u32

Then it should return an unsigned int.  You should used a sized integer typ=
e only when the size really matters (e.g. hardware registers or packed fiel=
ds in a structure).
[Sandeep] Agreed, will rectify.
