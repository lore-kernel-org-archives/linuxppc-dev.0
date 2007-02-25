Return-Path: <jordi.polo@iron-gate.net>
Message-ID: <45E1C20B.2070704@iron-gate.net>
Date: Sun, 25 Feb 2007 18:06:19 +0100
From: jordi <jordi.polo@iron-gate.net>
MIME-Version: 1.0
To: hvr@gnu.org, Pablo Ruiz Garcia <pablo.ruiz@iron-gate.net>,
	Linuxppc-dev@ozlabs.org,  linux-net@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk
Subject: how to extend the phy abstraction layer?
Content-Type: multipart/mixed; boundary="------------010909040704010309060608"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010909040704010309060608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

I want to add support for phy devices like ICplus' IC175C 
(http://www.icplus.com.tw/pp-IP175C.html) in the kernel in a sane and 
proper manner.  This kind of phy devices have only one phy address in 
the MII bus and has several  line connections, they name it integrated 
switch.
The current phy_device structure and the phy abstraction layer is not 
prepared for this kind of devices.   

How would be the best approach to expand the current phy abstraction 
layer to take into account this kind of devices?

I was thinking in something like changing the phy_device structure, 
divide it in MII bus related fields and physical connection related 
fields. The physical connection related fields will be together in a 
phy_connection structure. the phy_device structure will maintain a list 
of phy_connection structures.
The phy related functions will be changed to use the phy_connection 
structure (the phy_connection has a pointer to its parent phy_device 
structure).

There is any on-going project trying to give support to these devices ?


--
Jordi Polo
IronGate S.L R&D Team


--------------010909040704010309060608
Content-Type: text/x-vcard; charset=utf-8;
 name="jordi.polo.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jordi.polo.vcf"

begin:vcard
fn:Jordi Polo
n:Polo;Jordi
org:IronGate S.L.;R&D
adr;quoted-printable:;;C/. Hermanos Garc=C3=ADa Noblejas 39, 5=C2=AA planta Nave 4;Madrid;Madrid;28037;Spain
email;internet:jordi.polo@iron-gate.net
title:R&D Team member
tel;work:+34 902 88 60 01
tel;fax:+34 91 326 66 11
url:http://www.iron-gate.net
version:2.1
end:vcard


--------------010909040704010309060608--
