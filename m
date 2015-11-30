Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBBB21A0075
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:18:29 +1100 (AEDT)
Subject: [P.A. Semi] Does the ethernet interface work on your Electra, Chitra,
 Nemo, and Athena board?
To: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
References: <565AF986.9060106@xenosoft.de>
 <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: linux-netdev@vger.kernel.org
Message-ID: <565C1B55.4020207@xenosoft.de>
Date: Mon, 30 Nov 2015 10:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAOJe8K1911vDjMe9m_1vY6DSGpOk0TmL96Qf1whuNFXxHJesGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Denis,

Thank you for your answer. Sorry because of my description.

Yes, the driver probe function finds the device.

With kernel 4.4-rc3:

dmesg | grep -i eth0

[ 2.297473] eth0: PA Semi GMAC: intf 5, hw addr 02:00:e0:0a:30:00

dhclient eth0

RTNETLINK answers: Cannot allocate memory

With kernel 4.1.13:

dmesg | grep -i eth0

[ 2.328115] eth0: PA Semi GMAC: intf 5, hw addr 02:00:e0:0a:30:00
[ 37.130466] eth0: Link is up at 100 Mbps, full duplex.

Cheers,

Christian

On 30 November 2015 at 09:37 AM, Denis Kirjanov wrote:
> On 11/29/15, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> Hi All,
>>
>> Does the ethernet interface on your Electra, Chitra, Nemo, and Athena
>> board work with the release candidates of the kernel 4.4? Unfortunately
>> the P.A. Semi ethernet doesn't work on our Nemo boards with the release
>> candidates of the kernel 4.4. We have set the following entries in the
>> kernel config:
>>
>> CONFIG_NET_VENDOR_PASEMI=y
>> CONFIG_PASEMI_MAC=y
>>
>> Could you please test the P.A. Semi ethernet on your P.A. Semi boards?
> It's not clear from your descriptions what is not working. Does the
> driver probe function find  a device? Does the interface show up in
> the kernel? Can it send/receive packets?
>
> Also please CC netdev.
>
> Thanks.
>
>> Thanks in advance,
>>
>> Christian
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
