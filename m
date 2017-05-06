Return-Path: <linuxuser330250@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKrSK0SLxzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 May 2017 00:17:20 +1000 (AEST)
Subject: Re: WARNING: CPU: 0 PID: 1 at
 /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
 check_features+0x38/0x7c
To: Michael Ellerman <mpe@ellerman.id.au>,
 Mathieu Malaterre <mathieu.malaterre@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CA+7wUsyo5HEVrNFGaH0WGB5WTatX7R7t_s2XhcbZ3kSDsAh2hA@mail.gmail.com>
 <878tmdyllf.fsf@concordia.ellerman.id.au>
From: Linux User #330250 <linuxuser330250@gmx.net>
Message-ID: <b1d293d3-ebfe-94c0-0fd7-d1f85d7d7247@gmx.net>
Date: Sat, 6 May 2017 16:11:45 +0200
MIME-Version: 1.0
In-Reply-To: <878tmdyllf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 2017-05-04 um 12:15 schrieb Michael Ellerman:
> Mathieu Malaterre <mathieu.malaterre@gmail.com> writes:
>
>> Hi all,
>>
>> Does this dmesg output speaks to anyone here (smp kernel):
>>
>>
>> [    4.767389] ------------[ cut here ]------------
>> [    4.774668] WARNING: CPU: 0 PID: 1 at
>> /build/linux-dp17Ba/linux-4.9.18/arch/powerpc/lib/feature-fixups.c:208
>> check_features+0x38/0x7c
> Is there anything prior to the "cut here" line?
>
> cheers
>


I rebooted the system today (mind the new timings). This is the kernel:

# uname -a
Linux G4QS 4.9.0-2-powerpc-smp #1 SMP Debian 4.9.18-1 (2017-03-30) ppc 
GNU/Linux

This is the line above the cut line:
CPU features changed after feature patching!

And here 10 lines above the cut line, with time:
[    5.008787] PowerMac i2c bus mac-io 0 registered
[    5.008925] i2c i2c-2: No i2c address for 
/pci@f2000000/mac-io@17/i2c@18000/i2c-modem
[    5.009355] PowerMac i2c bus uni-n 1 registered
[    5.009611] PowerMac i2c bus uni-n 0 registered
[    5.009860] ledtrig-cpu: registered to indicate activity on CPUs
[    5.017397] NET: Registered protocol family 10
[    5.025443] mip6: Mobile IPv6
[    5.032460] NET: Registered protocol family 17
[    5.039579] mpls_gso: MPLS GSO support
[    5.046767] CPU features changed after feature patching!

I've posted the whole dmesg output on pastebin, valid for one month as 
of this posting:
https://pastebin.com/mK0zvVxQ


Cheers,
Linux User #330250
