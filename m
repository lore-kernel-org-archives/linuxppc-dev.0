Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 68AE12C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 23:44:07 +1000 (EST)
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <51DEB5F0.3000502@linux.vnet.ibm.com>
Date: Thu, 11 Jul 2013 15:44:01 +0200
Message-Id: <82D6488B-C6D7-475F-A16B-FC8AAC9E76A0@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru>	 <51DC4923.5010501@suse.de>
 <51DE7377.1060503@ozlabs.ru>	 <902F79B9-BB81-40A0-865D-94E7108DAC5E@suse.de>
 <1373546233.19894.85.camel@pasglop>
 <B526C260-1ADB-4B9F-B80A-46E5A9E53FF6@suse.de>
 <1373547392.19894.100.camel@pasglop> <51DEB5F0.3000502@linux.vnet.ibm.com>
To: chandrashekar shastri <cshastri@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
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


On 11.07.2013, at 15:41, chandrashekar shastri wrote:

> Hi All,
>=20
> I complied the latest kernel 3.10.0+ pulled from the git on top of  =
3.10.0-rc5+ by enabling the new Virtualiztaion features. The compliation =
was sucessfull, when I rebooted the machine it fails to boot with error =
as " systemd [1] : Failed to mount /dev : no such device.
>=20
> Is it problem with the KVM module?

Very unlikely. You're probably missing generic config options in your =
.config file. But this is very off topic for a) this thread and b) these =
mailing lists.


Alex
