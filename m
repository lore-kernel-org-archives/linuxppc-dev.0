Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CF2782C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 22:47:35 +1000 (EST)
Subject: Re: PCI device not working
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAKpAL0mErR3vR4AdSAT_vJG_kM=GvHnZR+b3dtSCN0GMU56pAw@mail.gmail.com>
Date: Fri, 5 Oct 2012 07:47:24 -0500
Message-Id: <750F6602-132E-449A-A852-43E739EA6D3E@kernel.crashing.org>
References: <11976036.82651349353479389.JavaMail.defaultUser@defaultHost>
 <62666FBA-F62E-44B7-814E-0718AE957EC0@kernel.crashing.org>
 <CAKpAL0m3YnsbbGxL+ejfyE4zfGE5LD9Qxb7oobHVaAZGE1_Jnw@mail.gmail.com>
 <CAKpAL0mErR3vR4AdSAT_vJG_kM=GvHnZR+b3dtSCN0GMU56pAw@mail.gmail.com>
To: Davide Viti <zinosat@tiscali.it>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 5, 2012, at 3:54 AM, Davide Viti wrote:

> (just realized I did not send this to the mailing list: sorry for the =
noise)
>=20
> Hi Kumar,
>=20
> 2012/10/4 Kumar Gala <galak@kernel.crashing.org>:
>>=20
>> On Oct 4, 2012, at 7:24 AM, Davide Viti wrote:
>>=20
>>> Hi,
>>> it turns out that if define CONFIG_PCI_NOSCAN in u-boot (as per =
[1]), the
>>> device behind the second controller is detected by the  Linux =
kernel.
>>>=20
>>> Would
>>> you suggest any particular patch I should apply to fix this (I'm =
using kernel
>>> 2.6.34)
>>>=20
>>> thanx alot in advance
>>> Davide
>>>=20
>>> [1] http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/20140
>>=20
>> My suggestion would be to try and dump all the controller registers =
between the case that works and doesn't and compare.  There's some minor =
setting difference that I'm guessing is causing issues.
>>=20
>> - k

When I said controller registers, I meant the FSL PCI controller and the =
CCSR registers not the PCI cfg register space

- k=
