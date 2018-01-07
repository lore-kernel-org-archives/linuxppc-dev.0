Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zDzCG5yG2zF0R6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 00:04:58 +1100 (AEDT)
Subject: Spectre+Meltdown
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Olof Johansson <olof@lixom.net>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
Date: Sun, 7 Jan 2018 14:04:40 +0100
MIME-Version: 1.0
In-Reply-To: <874lnzz5y3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

Thanks for your reply. We are using P.A. Semi and Freescale CPUs.

@Olof
Do you have some infos for us?

Thanks,
Christian


On 06/01/18 10:34, Michael Ellerman wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>
>> Hi All,
>>
>> Do we have some information regarding Spectre+Meltdown for our users?
>>
>> It could be that we have some security issues in our PowerPC CPUs.
> There's a statement from IBM here:
>
>    https://www.ibm.com/blogs/psirt/potential-impact-processors-power-family/
>
>
> I think you're mostly using pasemi CPUs right? I don't have any
> information on them, and obviously it's going to be hard to find anyone
> who might know. You might be best finding a proof of concept somewhere
> and actually testing it.
>
> cheers
>
