Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A78B1B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Aug 2010 02:28:28 +1000 (EST)
Subject: Re: [PATCH 00/27] KVM PPC PV framework v3
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
Date: Fri, 6 Aug 2010 11:28:21 -0500
Message-Id: <17DF4824-9EC7-44F4-9408-EA6241C33E70@kernel.crashing.org>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
To: Alexander Graf <agraf@suse.de>
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


On Jul 29, 2010, at 7:47 AM, Alexander Graf wrote:

> [without]
>=20
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > =
/dev/null; done
>=20
> real    0m14.659s
> user    0m8.967s
> sys     0m5.688s
>=20
> [with]
>=20
> debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > =
/dev/null; done
>=20
> real    0m7.557s
> user    0m4.121s
> sys     0m3.426s

Do you have #'s for w/o HV to compare to.

- k=
