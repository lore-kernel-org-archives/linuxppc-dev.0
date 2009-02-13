Return-Path: <tobias.knutsson@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id C0064DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 17:30:50 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so1118551wfd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 22:30:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40902121318i65ec44edtf119a6ad2d4d1570@mail.gmail.com>
References: <ccb913ac0902100507x69113827m757f3b8fbd0ac6f4@mail.gmail.com>
	<fa686aa40902121318i65ec44edtf119a6ad2d4d1570@mail.gmail.com>
Date: Fri, 13 Feb 2009 07:30:48 +0100
Message-ID: <ccb913ac0902122230t12e2977dw2bf720e4710b1438@mail.gmail.com>
Subject: Re: writel hangs system
From: Tobias Knutsson <tobias.knutsson@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There seems to be some magic force linked to this mailing list.
Whenever I post a question, the matter seems to resolve itself. :)

In order to stay as consistent as possible with the old 2.4 kernel, I
used the same mapping that they had:

0x50000000 - 0x6000000000 for memory
0x60000000 - 0x6100000000 for I/O

When I changed it to the default that was in the lite5200b device tree
I could access the memory regions as well.

Thanks for your help!

On Thu, Feb 12, 2009 at 22:18, Grant Likely <grant.likely@secretlab.ca> wro=
te:
> On Tue, Feb 10, 2009 at 6:07 AM, Tobias Knutsson
> <tobias.knutsson@gmail.com> wrote:
>> Hello,
>>
>> I'm in the process of porting a PCI-driver for a dsp-board from 2.4 to
>> 2.6. The probing of the driver goes well, IRQs are setup, resources
>> are claimed and remapped without any problems. Reading from I/O
>> regions also works well. However, when i try to read or write to a
>> memory region using readl/writel, the system instantly hangs. No
>> stacktrace or anything, it just stops.
>
> Hmmm.  Not good.  Are you able to access the memory regions from the
> U-Boot console?
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20

H=E4lsningar/Regards
Tobias Knutsson
