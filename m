Return-Path: <jwboyer@gmail.com>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51772B6F77
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 11:22:16 +1000 (EST)
Received: by qadz3 with SMTP id z3so3488116qad.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 18:22:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1339548038.9220.80.camel@pasglop>
References: <1336362768-31326-1-git-send-email-vhtnguyen@apm.com>
 <da2d8ae5f5008c4695d1898b9e121c1f@mail.gmail.com>
 <1339548038.9220.80.camel@pasglop>
Date: Tue, 12 Jun 2012 21:22:12 -0400
Message-ID: <CA+5PVA5KepDnQMtK7Gav+Hk-jch4t0MQZXUeTj3GG_T0Ld==JA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/44x: Support OCM(On Chip Memory) for APM821xx SoC
 and Bluestone board
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vinh Huu Tuong Nguyen <vhtnguyen@apm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2012 at 8:40 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2012-06-12 at 17:26 +0700, Vinh Huu Tuong Nguyen wrote:
>> > -----Original Message-----
>> > From: Vinh Nguyen Huu Tuong [mailto:vhtnguyen@apm.com]
>> > Sent: Monday, May 07, 2012 10:53 AM
>> > To: Benjamin Herrenschmidt; Paul Mackerras; Josh Boyer; Matt Porter;
>> > Grant Likely; Rob Herring; Duc Dang; David S. Miller; Kumar Gala; Li
>> > Yang; Ashish Kalra; Anatolij Gustschin; Liu Gang; linuxppc-
>> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; devicetree-
>> > discuss@lists.ozlabs.org
>> > Cc: Vinh Nguyen Huu Tuong
>> > Subject: [PATCH] powerpc/44x: Support OCM(On Chip Memory) for APM821xx
>> > SoC and Bluestone board
>
> Such a CC list won't get you any good will. Send it only to the relevant
> mailing lists with possibly the -one- concerned maintainer on CC. I
> doubt Dave Miller or Matt Porter give any damn about those patches.
>
> As for why it wasn't reviewed yet, well, reviewers are a finite resource
> with limited time dedicated to it. If the patch is properly formed and
> was posted to the linuxppc-dev@ozlabs.org, it should be tracked on
> patchwork.ozlabs.org and won't be lost. Double check it's there (if it's
> not, then the patch was probably corrupt).

It's there.  I just missed it until today.  My apologies Vinh.  I'll
do a more formal review tomorrow, but at first glance I'm concerned
with the sysfs usage.  The files in sysfs are supposed to be one file
per value, and you see to have something akin to /proc/meminfo in the
sysfs file being created.  Perhaps that would be better either split
into unique file names per field in sysfs, or in a debugfs file
instead?

Again, I'll review more closely tomrorow.

josh
