Return-Path: <pku.leo@gmail.com>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1A152C0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 00:13:21 +1000 (EST)
Received: by ggnk3 with SMTP id k3so2358982ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 07:13:19 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <56E7FB74-A29A-4658-9AC9-2C87A1A7ED3C@kernel.crashing.org>
References: <1342085776-13289-1-git-send-email-B38951@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A228F9@039-SN1MPN1-002.039d.mgd.msft.net>
 <56E7FB74-A29A-4658-9AC9-2C87A1A7ED3C@kernel.crashing.org>
Date: Thu, 12 Jul 2012 22:13:19 +0800
Message-ID: <CADRPPNT6S7HEm0j=8UnBBqfyxaNUZfbzt1vrE-HGrB=M5_L-yg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/sgmii: Add phy nodes in SGMII mode
From: Li Yang <leoli@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2012 at 8:18 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Jul 12, 2012, at 5:28 AM, Jia Hongtao-B38951 wrote:
>
>> Note that this patch works with uboot update.
>> Please refer to:
>> http://patchwork.ozlabs.org/patch/170627/
>>
>> -Hongtao.
>
> Will RGMII still work with this patch if I dont update u-boot?
>
> I'm assuming yes.

Yes.  We just add new nodes without modifying the original PHY nodes.

Leo
