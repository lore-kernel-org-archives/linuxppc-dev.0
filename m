Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 27BAD1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:42:46 +1100 (EST)
Received: by ywh17 with SMTP id 17so4623219ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 14:42:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200911212045.42767.arnd@arndb.de>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<e846a32c-5f37-4531-b23d-17c60d8b6449@SG2EHSMHS010.ehs.local>
	<fa686aa40911202351s4436a8a6r59abfe2cf130ca59@mail.gmail.com>
	<200911212045.42767.arnd@arndb.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 15:42:24 -0700
Message-ID: <fa686aa40911221442t4526dd65v5a0f9659e8767e47@mail.gmail.com>
Subject: Re: Bug in drivers/serial/of_serial.c?
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Neuendorffer <stephenn@xilinx.com>, Alon Ziv <alonz@discretix.com>,
	linuxppc-dev@lists.ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 21, 2009 at 12:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 21 November 2009, Grant Likely wrote:
>> BTW, while looking at that file... Arnd, does the .type = "serial"
>> stuff really need to be there?
>
> Well, serial is one of the few that actually has some preexisting
> binding with a well defined device-type, so I guess we should use
> it.

But device-type describes a OpenFirmware API, not a device register
interface.  Once we're in the kernel and talking to the hardware
directly, device-type has no real meaning because we're not using the
OpenFirmware interface to talk to serial devices in a generic manner.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
