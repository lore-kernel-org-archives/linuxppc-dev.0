Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA5542C0313
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 23:46:44 +1000 (EST)
Received: by mail-pa0-f46.google.com with SMTP id fa11so7933757pad.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 06:46:42 -0700 (PDT)
Message-ID: <51DEB73B.9090702@ozlabs.ru>
Date: Thu, 11 Jul 2013 23:46:35 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: chandrashekar shastri <cshastri@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru>	 <51DC4923.5010501@suse.de>
 <51DE7377.1060503@ozlabs.ru>	 <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
 <1373546233.19894.85.camel@pasglop>
 <B526C260-1ADB-4B9F-B80A-46E5A9E53FF6@suse.de>
 <1373547392.19894.100.camel@pasglop> <51DEB5F0.3000502@linux.vnet.ibm.com>
In-Reply-To: <51DEB5F0.3000502@linux.vnet.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
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

On 07/11/2013 11:41 PM, chandrashekar shastri wrote:
> Hi All,
> 
> I complied the latest kernel 3.10.0+ pulled from the git on top of 
> 3.10.0-rc5+ by enabling the new Virtualiztaion features. The compliation
> was sucessfull, when I rebooted the machine it fails to boot with error as
> " systemd [1] : Failed to mount /dev : no such device.
> 
> Is it problem with the KVM module?


Wrong thread actually, would be better if you started the new one.

And you may want to try this - http://patchwork.ozlabs.org/patch/256027/


-- 
Alexey
