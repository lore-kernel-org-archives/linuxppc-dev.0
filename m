Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C0F8DB7090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:31:59 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
Date: Thu, 13 Oct 2011 10:31:47 -0500
Message-Id: <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
 <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2011, at 9:14 AM, Tabi Timur-B04825 wrote:

> On Tue, Oct 11, 2011 at 11:53 PM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> On Sep 23, 2011, at 2:32 PM, Anatolij Gustschin wrote:
>>=20
>>> Remove wrong CONFIG_ prefix in Kconfig file.
>>>=20
>>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>>> ---
>>> arch/powerpc/platforms/85xx/Kconfig |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>=20
>> applied
>=20
> Why did you apply this patch?  Both Scott and I rejected it.

Because its fixing a real issue.  If we want to remove PHYS_64BIT =
support or make it optional for the board feel free to send another =
patch.

- k=
