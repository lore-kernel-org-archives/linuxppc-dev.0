Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id E257EDE0AD
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 04:52:40 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so697994hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 11:52:38 -0700 (PDT)
Message-ID: <fa686aa40807251152t22848f69l924b0f83f1871165@mail.gmail.com>
Date: Fri, 25 Jul 2008 14:52:38 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH v3 1/4] of: adapt of_find_i2c_driver() to be usable by SPI
	also
In-Reply-To: <9e4733910807251002w7da115e5r53600f1cf4e3891@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073311.8485.16226.stgit@trillian.secretlab.ca>
	<9e4733910807250840n48c6ae79l27af4f320b5b1df1@mail.gmail.com>
	<fa686aa40807250921v73bec21cya6b4cd494f12f2e8@mail.gmail.com>
	<9e4733910807251002w7da115e5r53600f1cf4e3891@mail.gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, akpm@linux-foundation.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 1:02 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 7/25/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Fri, Jul 25, 2008 at 11:40 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>  > On 7/25/08, Grant Likely <grant.likely@secretlab.ca> wrote:
>>  >>  + * First method is to lookup the compatible value in of_modalias_table.
>>  >>  + * Second is to look for a "linux,<modalias>" entry in the compatible list
>>  >>  + * and used that for modalias.  Third is to strip off the manufacturer
>>  >>  + * prefix from the first compatible entry and use the remainder as modalias
>>  >
>>  > I also think this is a problem. Embedding the name of Linux device
>>  > drivers into device firmware makes it almost impossible to rename the
>>  > device driver.  Again, what is a case where generic part numbers can't
>>  > be listed in the alias section of the linux device driver?
>>  >
>>  > Even eeprom was just fixed to take generic part numbers (at24).
>>
>> Again, I agree, but this change is very much a stop gap measure to get
>>  things working in a sane way without having to create bad device tree
>>  bindings (device tree bindings are hard to change, code is not).  I've
>>  been considering posting a patch to remove this clause from the
>>  functions, but that needs to be reviewed separately from this change.
>
> Isn't putting "compatible="linux,modalias"" into your device tree a
> really bad idea?

Yes, it is, but I still need to preserve existing behavior in this
patch.  That change needs to be reviewed separately.  I'll submit
another patch to deal with this.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
