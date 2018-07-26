Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bbFS09zyzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 12:11:56 +1000 (AEST)
Message-ID: <fb26bda65b80eef4916a94f5e4c534d55015d28d.camel@neuling.org>
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
From: Michael Neuling <mikey@neuling.org>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>,  Cyril Bur
 <cyrilbur@gmail.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul
 Mackerras <paulus@samba.org>, Simon Guo <wei.guo.simon@gmail.com>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, "Tobin C . Harding"
 <me@tobin.cc>,  linuxppc-dev@lists.ozlabs.org
Date: Thu, 26 Jul 2018 12:11:49 +1000
In-Reply-To: <20180725193647.GA23643@kermit-br-ibm-com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
 <20180725193647.GA23643@kermit-br-ibm-com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > Should we prefix every line with the PID to avoid this?
>=20
> That's possible.  An alternative would be prefixing each line with the
> process name and its PID, as in the first line.  For example:
>=20
>     pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000=
061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
>     pandafault[10758]: Instruction dump:
>     pandafault[10758]: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821f=
fc1 7c3f0b78 3d22fffe
>     pandafault[10758]: 392988d0 f93f0020 e93f0020 39400048 <99490000> 392=
00000 7d234b78 383f0040
>=20
> The above can be interleaved with other messages and we'll still be able
> to match process and its corresponding instruction dump.

LGTM.

Thanks!
Mikey
