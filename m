Return-Path: <j.glisse@free.fr>
Received: from postfix3-2.free.fr (postfix3-2.free.fr [213.228.0.169])
	by ozlabs.org (Postfix) with ESMTP id AF4462BF16
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jan 2005 22:24:08 +1100 (EST)
Message-ID: <41DFC28F.1000002@free.fr>
Date: Sat, 08 Jan 2005 12:22:55 +0100
From: Jerome Glisse <j.glisse@free.fr>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
References: <41DEA9D8.3000506@nortelnetworks.com>
In-Reply-To: <41DEA9D8.3000506@nortelnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: G5 noisier under linux than firmware or OSX
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen wrote:

> I've noticed that when booting, right around the time the kernel first 
> accesses my disks the fan speed jumps a bit.  It's not full-on vacuum 
> cleaner howling, just a bit noisier.
>
> I've only got the one machine so I can't do A/B comparisons, but it 
> seems to be quieter when running OSX.
>
> Is linux using the same fan speed parameters, or are we maybe a bit 
> conservative?

 From my memory, there have been some guess on values for
therm regulation as Apple seems to not give informations or
source code on that. Thus the values for regulating the fan are not
the same as OS X.

By the way, i also hear little more noise. The question is : Should
we lower the speed or stay with this conservative values ? :)

best,
Jerome Glisse
