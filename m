Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLhxj0ZW2zF0fK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:43:03 +1100 (AEDT)
Subject: Re: DPAA Ethernet problems with mainstream Linux kernels
To: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Darren Stevens <darren@stevens-zone.net>,
 Jamie Krueger <jamie@bitbybitsoftwaregroup.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ccafbcca-172b-11ae-7916-8bcd4bfa419c@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C70D5760C3F21F881074EC170@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <d7478110-68ae-34b3-51c5-487bb3e12527@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C1D81C867CF2D5A65D0EECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <4b50ee845f3.281d6f13@auth.smtp.1and1.co.uk>
 <DB3PR0402MB38496B4FB62904321A97186AECEA0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <2ca2be11-7e64-3055-0d06-7090d5dcc096@xenosoft.de>
Date: Tue, 16 Jan 2018 21:42:47 +0100
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB38496B4FB62904321A97186AECEA0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I compiled the RC8 of kernel 4.15 for the X5000 without PAMU support today.

Download: http://www.xenosoft.de/uImage_without_pamu.tar.gz

Please test it on your AmigaOne X5000.

Thanks,
Christian


On 16 January 2018 at 6:33PM, Madalin-cristian Bucur wrote:
>> The PAMU related errors may be relevant to the issue, if you have incorrect
>> settings you may have no traffic passing through. The PAMU configuration
>> should be made by the bootloader. Can you try to disable CONFIG_FSL_PAMU?
>>
>> Madalin
>>
>>
