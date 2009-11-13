Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id F0C61B8102
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 07:14:07 +1100 (EST)
Received: by gxk23 with SMTP id 23so2293675gxk.2
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 12:14:06 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <74ee2358-38c2-472b-9c53-2fb7ad51da60@VA3EHSMHS023.ehs.local>
References: <4AFD50F0.6050805@mocean-labs.com>
	<fa686aa40911131029uddb497ah7907ccd9dc23c6e3@mail.gmail.com>
	<74ee2358-38c2-472b-9c53-2fb7ad51da60@VA3EHSMHS023.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 13 Nov 2009 13:13:45 -0700
Message-ID: <fa686aa40911131213qaeebd9dt9eb066bb0ebbd17d@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] xilinx_spi: Split into platform and of driver,
	support new IP, platform independence.
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	=?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>,
	dbrownell@users.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 13, 2009 at 12:59 PM, John Linn <John.Linn@xilinx.com> wrote:
>> -----Original Message-----
>> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Gr=
ant Likely
>> Sent: Friday, November 13, 2009 11:30 AM
>> To: Richard R=F6jfors
>> Cc: spi-devel-general@lists.sourceforge.net; linuxppc-dev@ozlabs.org; An=
drew Morton;
>> dbrownell@users.sourceforge.net; John Linn
>> Subject: Re: [PATCH v3 0/4] xilinx_spi: Split into platform and of drive=
r, support new IP, platform
>> independence.
>>
>> On Fri, Nov 13, 2009 at 5:28 AM, Richard R=F6jfors
>> <richard.rojfors@mocean-labs.com> wrote:
>> > Hi,
>> >
>> > To follow is a series of patches against the xilinx_spi driver.
>> >
>> > The patchset is against 2.6.32-rc6
>> >
>> > The patchset addresses several problems in the current driver:
>> > * It's PPC only (OF and uses PPC specific memory operations)
>> > * Only supporting big endian writes
>> > * Supports only 8bit SPI, support for DS570 (also 16 or 32 bit) is add=
ed.
>> > * A platform driver is introduced for non OF capable architectures.
>> >
>> > These patches were posted as one big patch up to 4 iterations, not spl=
itted into 4.
>> >
>> > This version, 3, is updated after review from Grant Likely and John Li=
nn
>> >
>> > John Linn has also tested the code on PPC, I have only tested on X86.
>>
>> Applied to my 'test' branch on git.secretlab.ca. =A0There was a conflict
>> on patch 3/4 with a previous bugfix from John Linn. =A0Please check that
>> I've fixed it up correctly.
>
> I think I reverted that change as Richard's fixes it I believe.

It is a real bug fix, and so should be in a separate patch.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
