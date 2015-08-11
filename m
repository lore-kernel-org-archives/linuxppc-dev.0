Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F8251A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 00:09:13 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: "dpaa-drivers-devel@gforge.freescale.net"
 <dpaa-drivers-devel@gforge.freescale.net>, "ldup-devel@gforge.freescale.net"
 <ldup-devel@gforge.freescale.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mcswdev@freescale.com" <mcswdev@freescale.com>
Subject: SDK/ethernet git repository branches
Date: Tue, 11 Aug 2015 14:09:00 +0000
Message-ID: <BL2PR03MB545F17B878F5479D19AFB9FE67F0@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here is a short description of the SDK/ethernet repository branches used fo=
r the DPAA
drivers and Gianfar Ethernet driver.

:: DPAA Upstreaming branches:

:. ldup
 - development branch for the DPAA upstreamable drivers (QBMan, FMan, dpaa_=
eth)
 - changes are staged here for submission to the upstream mailing list for =
review &
    acceptance
 - automated tests are run in 3 stages on this branch when new changes are =
pushed
 - periodically rebased over the latest vanilla Linux kernel tag

:. ldup-sdk
 - development branch for the DPAA upstreamable drivers second wave content
 - changes staged here will not be sent in the first patch set or are meant=
 for long
    term integration of SDK code with upstreamable drivers
 - automated tests are run in 3 stages on this branch when new changes are =
pushed
 - periodically rebased over ldup; currently is left behind, working on get=
ting back on
    top of ldup

:: DPAA SDK branches:

:. dpaa-next
 - default development branch for the SDK DPAA drivers
 - changes are staged here for inclusion in the SDK Linux kernel tree
 - automated tests are run in 3 stages on this branch when new changes are =
pushed
 - periodically rebased over the SDK Linux kernel tree

:: DPAA LS1043 support branches:

:. dpaa-arm-next
 - development branch for the LS1043 support in the dpaa_eth drivers
 - changes were staged here for inclusion in the LS1043 Linux kernel tree h=
eld by Mingkai
 - this will disappear when LS1043 support is included in the SDK, its role=
 will be fulfilled
    by dpaa-next
 - was periodically rebased over dpaa-next
 - needs to be brought to date with changes from linux-v3.19-dpaa

:. linux-v3.19-dpaa
 - when LS1043 development continued on a different kernel version, dpaa-ne=
xt
    no longer was able to fulfill its role while still remaining based on d=
paa-next
 - here the hombrew LS1043 support branch prepared by Mingkai was updated t=
o
    contain the SDK1.8 codebase plus several patches that were required by =
the kernel
    upgrade and some ARM specific patches to the Ethernet drivers that were=
 not included
    in SDK1.8
 - the branch was used as a temporary staging area for the LS1043 DPAA Ethe=
rnet drivers
    code until it was pulled in the official LS1043 Linux tree ls1043-linux=
/linux-v3.19

:: Gianfar branch:

:. gfar-next
 - branch based on the vanilla kernel
 - currently based on v4.1 Linux kernel tag
 - automated testing setup in progress

:: Branches to add

:. dpaa-next-2.0
 - branch does not exist, it will be created for SDK1.9 development
 - will be based on the SDK 1.9 official tree when that will be communicate=
d
 - changes will be pulled from dpaa-next

:. dpaa-next-2.0
 - branch does not exist, it will be created for SDK2.0 development
 - will be based on the SDK 2.0 official tree when that will be communicate=
d
 - changes will be pulled from dpaa-next and ldup

:: Branches to remove
 - temporary branches used as temporary vehicles for the DPAA teams collabo=
ration may be added here
 - these temporary branches need to be removed when their purpose was met

:. qmanv2_squashed
 - changes to ldup QBMan patches were pushed here by Roy for review & inclu=
sion in ldup

:. qman_v2
 - changes to ldup QBMan patches were pushed here by Roy for review & inclu=
sion in ldup

Regards,
Madalin

PS: this information will be updated in Sharepoint at this address:

https://freescale.sharepoint.com/sites/dngsst/nrt/sdktech/ethconn/EthernetC=
onnectivity/SDK%20ethernet%20git%20repository%20branches.aspx
