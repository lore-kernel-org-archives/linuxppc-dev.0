MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MPC8260 ethernet transmit problem
Date: Tue, 15 Jun 2004 09:05:38 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB089DD8@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check your port initialization: do you have the Tx (and Rx) clock configured properly?  Do you have the Tx data and control lines configured properly?

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
