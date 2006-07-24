Return-Path: <Haiying.Wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Query regarding Gianfar Ethernet Driver for MPC8555E
Date: Mon, 24 Jul 2006 06:59:17 -0700
Message-ID: <DDEDA444F5BF0E41AC8649FB40392C29017EA1F5@az33exm23.fsl.freescale.net>
In-Reply-To: <20060724134454.90046.qmail@web8903.mail.in.yahoo.com>
From: "Wang Haiying-r54964" <Haiying.Wang@freescale.com>
To: "Alok Barsode" <namaskar_alok@yahoo.co.in>, <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8555E only supports TWO TSECs. 8548E supports four eTSECs.

Haiying=20

> >>-----Original Message-----
> >>From:=20
> >>linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@ozlabs.
org [mailto:linuxppc-embedded->
>>bounces+haiying.wang=3Dfreescale.com@ozlabs.org] On Behalf Of=20
> >>Alok Barsode
> >>Sent: Monday, July 24, 2006 9:45 AM
> >>To: Linuxppc-embedded@ozlabs.org
> >>Subject: Query regarding Gianfar Ethernet Driver for MPC8555E
> >>
> >>Hello,
> >>I am a newbie, working on the MPC8555E(Freescale).=20
> >>
> >>The Gianfar Ethernet Driver configures the TSECs on the=20
> >>board.I see that out of the 4 Ethernet Interfaces only 2=20
> >>are configured when the gianfar driver is loaded(I have=20
> >>complied it as a modules).I checked this via "ifconfig"=20
> >>command. Out of the 4 ports, 2 are located on the basic=20
> >>carrier board and the other two on the IOCard expansion.
> >>
> >>I wonder why all four of them are not configured?
> >>
> >>Thanks in advance,
> >>Alok.
> >>
> >>
> >>__________________________________________________
> >>Do You Yahoo!?
> >>Tired of spam?  Yahoo! Mail has the best spam protection=20
> >>around http://mail.yahoo.com=20
> >>_______________________________________________
> >>Linuxppc-embedded mailing list
> >>Linuxppc-embedded@ozlabs.org
> >>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
