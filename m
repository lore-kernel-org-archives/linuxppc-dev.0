Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C84682C0093
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2012 23:22:34 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344033253.24037.70.camel@pasglop>
Date: Sat, 4 Aug 2012 08:22:34 -0500
Message-Id: <7009C85C-A90F-4477-821A-507259A8F595@kernel.crashing.org>
References: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
 <1344033253.24037.70.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 3, 2012, at 5:34 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2012-08-03 at 08:39 -0500, Kumar Gala wrote:
>> Ben,
>>=20
>> Weekly bug fix pull request.
>=20
> Well, Linus is on holiday so I don't think it makes sense for me to =
ask
> him to pull anything just yet... I'll put it in my tree some time next
> week and will send it along with whatever I have as well when it looks
> like he might be back :-)

No problem, just trying to get into a weekly cadence of pull requests.

- k

>=20
> Cheers,
> Ben.
>=20
>> - k
>>=20
>> The following changes since commit =
0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
>>=20
>>  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
>>=20
>> are available in the git repository at:
>>=20
>>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git =
merge
>>=20
>> for you to fetch changes up to =
c9f11c30374329a0d2a88cf05281ca49d8eca9ab:
>>=20
>>  powerpc/fsl-pci: Only scan PCI bus if configured as a host =
(2012-08-03 08:25:52 -0500)
>>=20
>> ----------------------------------------------------------------
>> Jia Hongtao (1):
>>      powerpc/fsl-pci: Only scan PCI bus if configured as a host
>>=20
>> arch/powerpc/sysdev/fsl_pci.c |   13 ++++++++-----
>> 1 file changed, 8 insertions(+), 5 deletions(-)
>=20
