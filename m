From: "T Michael Turney" <tmike@recipes4linux.com>
To: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8260 ethernet transmit problem
Date: Tue, 15 Jun 2004 08:39:54 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHCEPHCJAA.tmike@recipes4linux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <065ACD8E84315E4394C835E398C8D5EB089DD8@cossmgmbx02.email.corp.tld>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also check the PHY initialization function.
Cheers,
T.mike

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
VanBaren, Gerald (AGRE)
Sent: Tuesday, June 15, 2004 8:06 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: MPC8260 ethernet transmit problem



Check your port initialization: do you have the Tx (and Rx) clock configured
properly?  Do you have the Tx data and control lines configured properly?

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> matik@ug.bilkent.edu.tr
> Sent: Tuesday, June 15, 2004 1:37 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: MPC8260 ethernet transmit problem
>
>
>
> Hi all,
>
> I am using Windriver SBCPowerQUICC2 with MPC8265 on it with
> 2.4.26 kernel. When I configure FCC ethernet on one of
> FCC1/2/3 it does not transmit any packet through channel
> although it successfully calls 'fcc_enet_xmit' function.
> Note: reception works.
>
> Thanks.
> matik
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
