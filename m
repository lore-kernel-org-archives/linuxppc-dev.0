Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DD531A0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 03:49:00 +1000 (EST)
Message-ID: <53A1CF96.1070907@xenosoft.de>
Date: Wed, 18 Jun 2014 19:42:46 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Subject: Kernel 3.15: Boot problems with a PA6T board
References: <25927053.1589.1403105603389.JavaMail.adrian@Gurnard>
In-Reply-To: <25927053.1589.1403105603389.JavaMail.adrian@Gurnard>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.06.14 17:33, Adrian Cox wrote:
>
> ----- Original Message -----
>> From: "Christian Zigotzky" <chzigotzky@xenosoft.de>
>>>> Christian
>>> But my opinion is, that's normal for the SB600 south bridge to
>>> presents itself as multiple devices on the PCIe bus on x86 PCs. I
>>> see
>>> a lot of PCs with SB600 south bridge on the internet. And the Linux
>>> kernel works with this south bridge. Or is it a powerpc issue?
>>>
> It is a powerpc issue. The SB600 connects to the AMD north bridge in a PC using a mode which is not PCIe compliant, and this makes the SB600 internal units appear as though they are on the root bus of a legacy PC. The powerpc does not have this built-in SB600 support.
>
>
> Adrian
>
