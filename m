Return-Path: <cshastri@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37EAC2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 23:41:19 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cshastri@linux.vnet.ibm.com>;
 Thu, 11 Jul 2013 19:04:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 23CCAE004F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 19:10:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6BDf2En34537600
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 19:11:02 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6BDf4QH009864
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 23:41:05 +1000
Message-ID: <51DEB5F0.3000502@linux.vnet.ibm.com>
Date: Thu, 11 Jul 2013 19:11:04 +0530
From: chandrashekar shastri <cshastri@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru>	 <51DC4923.5010501@suse.de>
 <51DE7377.1060503@ozlabs.ru>	 <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
 <1373546233.19894.85.camel@pasglop>
 <B526C260-1ADB-4B9F-B80A-46E5A9E53FF6@suse.de>
 <1373547392.19894.100.camel@pasglop>
In-Reply-To: <1373547392.19894.100.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I complied the latest kernel 3.10.0+ pulled from the git on top of  
3.10.0-rc5+ by enabling the new Virtualiztaion features. The compliation 
was sucessfull, when I rebooted the machine it fails to boot with error 
as " systemd [1] : Failed to mount /dev : no such device.

Is it problem with the KVM module?

Thanks,
Shastri

On 07/11/2013 06:26 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-11 at 14:50 +0200, Alexander Graf wrote:
>>> Not really no. But that would do. You could have give a more useful
>>> answer in the first place though rather than stringing him along.
>> Sorry, I figured it was obvious.
> It wasn't no, because of the mess with modules and the nasty Makefile we
> have in there. Even I had to scratch my head for a bit :-)
>
> Ben.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
