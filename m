Return-Path: <matvejchikov@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 458D4DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Mar 2007 05:15:49 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so598504nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 12:15:47 -0700 (PDT)
Message-ID: <8496f91a0703301215r77c8e838pa9cd88ddd639a170@mail.gmail.com>
Date: Fri, 30 Mar 2007 23:15:47 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MDIO bus description and bitbang property
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_77801_3227975.1175282147270"
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_77801_3227975.1175282147270
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!

As I see it mpc82xx MDIO description given in DTS file contains several
inaccuracies concerning 'bitbang' property. Thus, 'bitbang' is the property
of MDIO bus, but not a device on the bus (PHY for ex.). I have changed
fs_enet_of_init() a little bit. Does anyone require such a patch?

Matvejchikov Ilya.

------=_Part_77801_3227975.1175282147270
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all!<br><br>As I see it mpc82xx MDIO description given in DTS file contains several inaccuracies concerning &#39;bitbang&#39; property. Thus, &#39;bitbang&#39; is the property of MDIO bus, but not a device on the bus (PHY for ex.). I have changed fs_enet_of_init() a little bit. Does anyone require such a patch?
<br><br>Matvejchikov Ilya.<br>

------=_Part_77801_3227975.1175282147270--
