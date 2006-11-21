Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 989EB67C82
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 06:56:51 +1100 (EST)
Message-ID: <45635982.8010602@am.sony.com>
Date: Tue, 21 Nov 2006 11:54:42 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com>	<17762.59947.937875.546225@cargo.ozlabs.ibm.com>	<20061121132253.GA17530@lst.de>
	<200611211442.31667.arnd@arndb.de>
In-Reply-To: <200611211442.31667.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Olof Johansson <olof@lixom.net>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 21 November 2006 14:22, Christoph Hellwig wrote:
>> The whole port is hypervisor-specific. =EF=BF=BDIt should be called ps=
3hv or
>> sonyhv (in case the plan for more hardware that's crippled by this
>> hypervisor)=20
>=20
> The hypervisor has a name, it's called 'lv1', and the port already
> uses that identifier for the low-level interfaces.
> If the platform is named after the hypervisor, we should not make up
> a new name but use the one that is already there.


Actually, the HV name is 'Cell OS LV1'.  'platforms/cell_os_lv1', or even
'platforms/lv1' -- I consider those perhaps even more 'meaningless' than
ps3pf.


-Geoff
