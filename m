Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 679A3B6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 08:58:47 +1100 (EST)
Received: by ywh39 with SMTP id 39so3703082ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 13:58:45 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <a1cde516-ea22-4411-bae1-74878f6bee43@SG2EHSMHS002.ehs.local>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
	<c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
	<200911191833.08254.arnd@arndb.de>
	<a1cde516-ea22-4411-bae1-74878f6bee43@SG2EHSMHS002.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 14:58:24 -0700
Message-ID: <fa686aa40911201358n5e5eb871wbfa523bfc9adb59d@mail.gmail.com>
Subject: Re: Bug in drivers/serial/of_serial.c?
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Linn <linnj@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2009 at 10:42 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
> [mailto:linuxppc-dev-
>> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Arnd
> Bergmann
>> Sent: Thursday, November 19, 2009 9:33 AM
>> To: Stephen Neuendorffer
>> Cc: John Linn; Alon Ziv; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: Bug in drivers/serial/of_serial.c?
>>
>> On Thursday 19 November 2009, Stephen Neuendorffer wrote:
>> > If the problem is in the device trees that are being generated, we
>> > should fix the issue there.
>> > We've been trying to avoid putting the fully specified IP versions
> in
>> > the kernel like this, since
>> > the IP changes so often.
>>
>> No, the problem that Alon has is that the firmware currently has no
>> way whatsoever to give a correct device tree, because of-serial.c
>> does not even know about ns16550a.
>>
>> The patch adds both a special-case for the specific uart he
>> is using so that one is grandfathered in and a new compatible
>> value so future boards can specify both ns16550a and ns16550.
>
> That's true... =A0The 16550a line still needs to get added, but not the
> xlnx-
> specific line.

The xlnx- line should be added and is entirely appropriate for exactly
the reason Arnd stated.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
