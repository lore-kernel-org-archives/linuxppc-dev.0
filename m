Return-Path: <sunder.svit@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by ozlabs.org (Postfix) with ESMTP id CBEFADDF09
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 05:30:12 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id s27so511732ele.3
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 10:30:10 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 21 Feb 2009 00:00:10 +0530
Message-ID: <d90126080902201030w2527e7eby27d58ddadd0429c1@mail.gmail.com>
Subject: eTSEC queries on 8548E
From: sunder ramani <sunder.svit@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd2e754d2540804635dd796
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd2e754d2540804635dd796
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am a newbie to PowerPC architecture and eTSEC. I have some queries:

1. Is there a way for me to configure different eTSECs in different media
modes? I understand that the MII interface does the same thing; yet do I
have to take some explicit care in the drivers for the eTSEC to
differentiate between a copper and fiber interface? Is this task of the SW
or is this configuration basically by the HW.

2. My custom board has the TSECs connected to a Marvell switch; one of the
ports being connected via the RGMII interface to a copper media; whilst the
other connected via the RGMII interface to another port on the switch via
the SGMII interface. Do I need to make any changes in the driver to effect
this configuration. I referred the gianfar, mdio, phy, mii drivers; but
couldnt find any specific code which would enable me to differentiate the
media interfaces.

3. My HW team tells me to write specific values to the PHY registers which
will differentiate the media interfaces to the Marvell switch via the
MDIO/MDCTL configuration lines from the MPC. If this is the case,
a. Would it be recommended to implement a PHY-ID specific implementation for
writing to the PHY registers in the gfar_enet_open when the phy_connect
function is called? OR
b. Would it be recommended to pass some kind of member through the DTS file
to the kernel, therbey affecting a change in the platform specific file.

Can any one please help me clear off these queries?

Thanx!
Sundar

--000e0cd2e754d2540804635dd796
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, </div>
<div>&nbsp;</div>
<div>I am a newbie to PowerPC architecture and eTSEC. I have some queries:<=
/div>
<div>&nbsp;</div>
<div>1. Is there a way for me to configure different eTSECs in different me=
dia modes? I understand that the MII interface does the same thing; yet do =
I have to take some explicit care in the drivers for the eTSEC to different=
iate between a copper and fiber interface? Is this task of the SW or is thi=
s configuration basically by the HW.</div>

<div>&nbsp;</div>
<div>2. My custom board has the TSECs connected to a Marvell switch; one of=
 the ports being connected via the RGMII interface to a copper media; whils=
t the other connected via the RGMII interface to another port on the switch=
 via the SGMII interface. Do I need to make any changes in the driver to ef=
fect this configuration. I referred the gianfar, mdio, phy, mii drivers; bu=
t couldnt find any specific code which would enable me to differentiate the=
 media interfaces.</div>

<div>&nbsp;</div>
<div>3. My HW team tells me to write specific values to the PHY registers w=
hich will differentiate the media interfaces to the Marvell switch via the =
MDIO/MDCTL configuration lines from the MPC. If this is the case,</div>

<div>a. Would it be recommended to implement a PHY-ID specific implementati=
on for writing to the PHY registers in the gfar_enet_open when the phy_conn=
ect function is called? OR</div>
<div>b. Would it be recommended to pass some kind of member through the DTS=
 file to the kernel, therbey affecting a change in the platform specific fi=
le.</div>
<div>&nbsp;</div>
<div>Can any one please help me clear off these queries?</div>
<div>&nbsp;</div>
<div>Thanx!</div>
<div>Sundar</div>

--000e0cd2e754d2540804635dd796--
