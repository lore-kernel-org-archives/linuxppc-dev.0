Return-Path: <pku.leo@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F25C1B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 14:10:30 +1000 (EST)
Received: by yhnn12 with SMTP id n12so115048yhn.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2012 21:10:28 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4FCFA17F.3050207@freescale.com>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-4-git-send-email-chenhui.zhao@freescale.com>
 <4FC93D74.3090200@freescale.com>
 <20120604113609.GC20676@localhost.localdomain>
 <4FCD3E8B.30805@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F09335D27@039-SN2MPN1-022.039d.mgd.msft.net>
 <4FCE2FB8.9080307@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F093360C1@039-SN2MPN1-022.039d.mgd.msft.net>
 <4FCE4A5A.3020603@freescale.com>
 <CADRPPNSzTNPkNExBnNu1iD2hqyRG=Cw+y+PnjTRWxjP_ib1Kww@mail.gmail.com>
 <4FCFA17F.3050207@freescale.com>
Date: Thu, 7 Jun 2012 12:10:28 +0800
Message-ID: <CADRPPNS3riBaC_onHKAFn2X_tnW5Z0=a2zyxfZy1f77oEe2Jbw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup event
 source
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 7, 2012 at 2:29 AM, Scott Wood <scottwood@freescale.com> wrote:
> On 06/05/2012 11:06 PM, Li Yang wrote:
>> On Wed, Jun 6, 2012 at 2:05 AM, Scott Wood <scottwood@freescale.com> wro=
te:
>>> You ignored "what about devices other than ethernet".
>>
>> No, I haven't. =C2=A0Other devices are so at least for now.
>
> I don't understand that last sentence. =C2=A0Other devices are what?

Probably I misunderstood your question "what about devices other than
ethernet".  Did you mean how would other devices other than ethernet
know how to set it?

Other wakeup capable devices can call the API when it is up and
running.  It will be the pmc driver's responsibility to find out if
that specific device can be configured as a wakeup source for the SoC.

Leo
