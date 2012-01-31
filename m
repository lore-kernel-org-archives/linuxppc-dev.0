Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E334B71A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 06:10:55 +1100 (EST)
Message-ID: <4F283CB7.4050908@freescale.com>
Date: Tue, 31 Jan 2012 13:10:47 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2 v2] powerpc/dts: Add dts for p1025rdb board
References: <1328003481-31821-1-git-send-email-B32736@freescale.com>
 <DDC3CACD-1B1C-4826-A839-65D42395ACEA@kernel.crashing.org>
In-Reply-To: <DDC3CACD-1B1C-4826-A839-65D42395ACEA@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
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

On 01/31/2012 09:55 AM, Kumar Gala wrote:
> 
> On Jan 31, 2012, at 3:51 AM, Zhicheng Fan wrote:
>> Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
>> ---
>> arch/powerpc/boot/dts/fsl/p1025si-post.dtsi |  228 +++++++++++++++++++++
>> arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi  |   70 +++++++
>> arch/powerpc/boot/dts/p1025rdb.dts          |  137 +++++++++++++
>> arch/powerpc/boot/dts/p1025rdb.dtsi         |  286 +++++++++++++++++++++++++++
>> arch/powerpc/boot/dts/p1025rdb_36b.dts      |   88 ++++++++
>> 5 files changed, 809 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-post.dtsi
>> create mode 100644 arch/powerpc/boot/dts/fsl/p1025si-pre.dtsi
>> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dts
>> create mode 100644 arch/powerpc/boot/dts/p1025rdb.dtsi
>> create mode 100644 arch/powerpc/boot/dts/p1025rdb_36b.dts
> 
> For the p1024 & p1025 I do NOT want to add new dts/fsl/p1025si*.dtsi files.  We should use the p1020 and p1021 as they are identical.

Are they sufficiently software compatible that we want to use
p1020/p1021 in all the compatible strings?  If yes, how was this verified?

-Scott
