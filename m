Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2F42B6F0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 16 Aug 2010 23:12:03 +1000 (EST)
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <17DF4824-9EC7-44F4-9408-EA6241C33E70@kernel.crashing.org>
Date: Mon, 16 Aug 2010 15:11:53 +0200
Message-Id: <B9621BC4-4C9D-4C51-89A7-ACE38955DEE5@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
	<17DF4824-9EC7-44F4-9408-EA6241C33E70@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.08.2010, at 18:28, Kumar Gala wrote:

>=20
> On Jul 29, 2010, at 7:47 AM, Alexander Graf wrote:
>=20
>> [without]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > =
/dev/null; done
>>=20
>> real    0m14.659s
>> user    0m8.967s
>> sys     0m5.688s
>>=20
>> [with]
>>=20
>> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > =
/dev/null; done
>>=20
>> real    0m7.557s
>> user    0m4.121s
>> sys     0m3.426s
>=20
> Do you have #'s for w/o HV to compare to.

Native was around 2-3 seconds overall. So we still have quite a big =
impact on performance, but things are improving :).

Alex
