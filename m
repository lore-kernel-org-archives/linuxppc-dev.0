Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3DC3EB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 10:44:07 +1100 (EST)
Subject: Re: [PATCH 1/2 v2] powerpc/dts: Add dts for p1025rdb board
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F283CB7.4050908@freescale.com>
Date: Tue, 31 Jan 2012 17:44:11 -0600
Message-Id: <7D155016-AC91-440A-A88F-FEEF85C13184@kernel.crashing.org>
References: <1328003481-31821-1-git-send-email-B32736@freescale.com>
 <DDC3CACD-1B1C-4826-A839-65D42395ACEA@kernel.crashing.org>
 <4F283CB7.4050908@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhicheng Fan <b32736@freeescale.com>,
 Zhicheng Fan <B32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 31, 2012, at 1:10 PM, Scott Wood wrote:

> On 01/31/2012 09:55 AM, Kumar Gala wrote:
>>=20
>> On Jan 31, 2012, at 3:51 AM, Zhicheng Fan wrote:
>>> Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
>>> ---
>>> arch/powerpc/boot/dts/fsl/p1025si-post.dtsi |  228 =
+++++++++++++++++++++
>>> arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi  |   70 +++++++
>>> arch/powerpc/boot/dts/p1025rdb.dts          |  137 +++++++++++++
>>> arch/powerpc/boot/dts/p1025rdb.dtsi         |  286 =
+++++++++++++++++++++++++++
>>> arch/powerpc/boot/dts/p1025rdb_36b.dts      |   88 ++++++++
>>> 5 files changed, 809 insertions(+), 0 deletions(-)
>>> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-post.dtsi
>>> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi
>>> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dts
>>> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dtsi
>>> create mode 100644 arch/powerpc/boot/dts/p1025rdb_36b.dts
>>=20
>> For the p1024 & p1025 I do NOT want to add new dts/fsl/p1025si*.dtsi =
files.  We should use the p1020 and p1021 as they are identical.
>=20
> Are they sufficiently software compatible that we want to use
> p1020/p1021 in all the compatible strings?  If yes, how was this =
verified?

They are the identical silicon just in different physical packages.  It =
was verified by me asking the FSL marketing team.

I'll work up a patch to add some comments to the p1020 & p1021si dts =
files about being the same for p1024/p1025.

- k=
