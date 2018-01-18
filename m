Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMbln3Xc6zF0hF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 18:52:34 +1100 (AEDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: DPAA Ethernet problems with mainstream Linux kernels
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <ae31b47c-b72b-a1b5-7d5f-54f77db8e282@bitbybitsoftwaregroup.com>
Date: Thu, 18 Jan 2018 08:52:14 +0100
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Darren Stevens <darren@stevens-zone.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-Id: <C6E81382-51A7-43F0-AC74-F3842F646620@xenosoft.de>
References: <ccafbcca-172b-11ae-7916-8bcd4bfa419c@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C70D5760C3F21F881074EC170@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <d7478110-68ae-34b3-51c5-487bb3e12527@bitbybitsoftwaregroup.com>
 <DB3PR0402MB3849C1D81C867CF2D5A65D0EECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <4b50ee845f3.281d6f13@auth.smtp.1and1.co.uk>
 <DB3PR0402MB38496B4FB62904321A97186AECEA0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <ae31b47c-b72b-a1b5-7d5f-54f77db8e282@bitbybitsoftwaregroup.com>
To: Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jamie,

Many thanks for your effort. If you need a new kernel for testing please let=
 me know.

Cheers,
Christian

Sent from my iPhone

> On 18. Jan 2018, at 02:59, Jamie Krueger <jamie@bitbybitsoftwaregroup.com>=
 wrote:
>=20
> Hi Madalin,
>=20
> On 01/16/2018 11:33 AM, Madalin-cristian Bucur wrote:
>=20
> Here are some results from testing on the X5000/20 with 4.15.0-rc8
> (w/CONFIG_FSL_PAMU disabled):
>=20
> In my tests I can now get the interface to obtain an IP Address via DHCP,
> at least *part* of the time that is.
>=20
> Here is a link to a screenshot of a Wireshark capture which shows
> a successful DHCP request/response for the X5000/20, followed by some
> failed ping attempts.
>=20
> (This traffic was captured on an external machine on the same subnet, and n=
ot from the X5000/20 itself)
> http://bitbybitsoftwaregroup.com/share/X5000-DHCP-Answered-Wireshark.png
>=20
> Additionally, here is a link to the export of the packet data shown in the=
 above image:
> http://bitbybitsoftwaregroup.com/share/Wireshark-X5000-DHCP-Success.html
>=20
> As you can see by this example, even when the interface does obtain an IP a=
ddress via
> DHCP (about half the time), subsequent traffic still fails to receive resp=
onses.
>=20
> In this example, I attempt to ping the gateway (192.168.1.1), and one or t=
wo other
> local addresses, and nothing pings back (even when trying Skateman's sugge=
stion
> of expanding the buffers for the interface -
>=20
> "A workaround to keep the nic alive a bit longer.... is the following comm=
and
> ip link set eth0 qlen 10000"
>=20
> For reference:
>=20
> I have attached the Kernel config that the version I tested was built with=
.
> Also, I have attached the dmesg output I am currently seeing.
>=20
> --=20
> Best Regards,
>=20
> Jamie Krueger
> BITbyBIT Software Group LLC
>=20
> <proc_config-4.15.0-rc8-NO_PAMU.txt>
> <fsl_dmesg_output.txt>
