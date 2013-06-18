Return-Path: <glikely@secretlab.ca>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B1D142C0299
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jun 2013 22:14:04 +1000 (EST)
Received: by mail-ie0-f175.google.com with SMTP id a13so9215047iee.6
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jun 2013 05:14:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <32351.1371553495@ale.ozlabs.ibm.com>
References: <1371244086-9189-1-git-send-email-grant.likely@linaro.org>
 <1371244086-9189-9-git-send-email-grant.likely@linaro.org>
 <4521.1371518445@ale.ozlabs.ibm.com> <5220.1371518734@ale.ozlabs.ibm.com>
 <CACxGe6s+K0xF0pnLjKoKXtz_YNoeM2+erhr_g2dX4ONpddRNGA@mail.gmail.com>
 <20130618094617.9BFA93E0D88@localhost> <32351.1371553495@ale.ozlabs.ibm.com>
From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 18 Jun 2013 13:13:42 +0100
Message-ID: <CACxGe6spx0wP2ceVcP1AqZwOUE+Ki9Ug1ksfRQG3DMWxpfiG8A@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] irqdomain: Refactor irq_domain_associate_many()
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 18, 2013 at 12:04 PM, Michael Neuling <mikey@neuling.org> wrote:
> Grant Likely <grant.likely@linaro.org> wrote:
>
>> On Tue, 18 Jun 2013 10:05:31 +0100, Grant Likely <grant.likely@linaro.org> wrote:
>> > On Tue, Jun 18, 2013 at 2:25 AM, Michael Neuling <mikey@neuling.org> wrote:
>> > > Michael Neuling <mikey@neuling.org> wrote:
>> > >
>> > >> Grant,
>> > >>
>> > >> In next-20130617 we are getting the below crash on POWER7.  Bisecting,
>> > >> points to this patch (d39046ec72 in next)
>> > >
>> > > Also, reverting just d39046ec72 fixes the crash in next-20130617.
>> >
>> > Odd. Of all the changes in that series, I would not have expected that
>> > one to cause any problems. I'm digging into it now...
>>
>> Ugh. I flubbed the commit. Try this patch. It should solve the problem:
>>
>
> Yep, it fixes it.  Thanks.

Excellent, thanks for testing.

g.
