Return-Path: <michael.guntsche@it-loops.com>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E933E2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 03:32:02 +1000 (EST)
Received: by mail-vc0-f180.google.com with SMTP id gf11so3132047vcb.39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:31:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1371514253.9073.8@snotra>
References: <1371241083.2996.7@snotra> <2435509.QyTW5GJC53@pcimr>
 <1371514253.9073.8@snotra>
Date: Tue, 18 Jun 2013 19:31:58 +0200
Message-ID: <CALG0vJszdSp+HViLq3hL6BOASGrasHx34AgtUExCS3FoOa4uvw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/pci: Fix setup of Freescale PCI / PCIe
 controllers
From: Michael Guntsche <michael.guntsche@it-loops.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Rojhalat Ibrahim <imr@rtschenk.de>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 18, 2013 at 2:10 AM, Scott Wood <scottwood@freescale.com> wrote:
> On 06/17/2013 08:15:33 AM, Rojhalat Ibrahim wrote:
>>
>> On Friday 14 June 2013 15:18:03 Scott Wood wrote:
>> > On 83xx:
>> > cc1: warnings being treated as errors
>> > /home/scott/fsl/git/linux/upstream/arch/powerpc/sysdev/fsl_pci.c:100:23:
>> > error: 'fsl_indirect_pcie_ops' defined but not used
>> > make[2]: *** [arch/powerpc/sysdev/fsl_pci.o] Error 1
>> > make[2]: *** Waiting for unfinished jobs....
>> >
>> > I can fix this when applying, but this makes me wonder how you tested
>> > it, given that the whole point is to fix 83xx...  Did you fix this and
>> > then accidentally sent a stale version?
>> >
>> > Also, please be careful that the patch doesn't get line wrapped -- I
>> > had to manually unwrap a couple places.  Use git send-email if you
>> > can't get KMail to cooperate.
>> >
>> > -Scott
>>
>> Sorry about the mess. I'll send a v3.
>> Please note: I don't have an 83xx system. So I can only test if it
>> compiles,
>> which I obviously did not do with the right config.
>
>
> OK, so it looks like it was Michael who ran into the problem on 83xx.
> Michael, could you test the v3 patch that Rojhalat posted?
>
> -Scott

I did a quick check against -rc6 and the system compiles and boots up fine.

/Mike
