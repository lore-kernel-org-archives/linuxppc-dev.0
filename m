Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id 78D3FB7D25
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 12:36:50 +1000 (EST)
Received: by qyk27 with SMTP id 27so3622680qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 19:36:48 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 23 Apr 2010 10:36:48 +0800
Message-ID: <x2v48abf2c21004221936kf5ca0a49mbf476d379038568@mail.gmail.com>
Subject: My MDIO is acting strange
From: Peter Pan <pppeterpppan@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm porting Linux 2.6.32.6 to my MPC8247 based board. Our FCC1 and
FCC2 are used as 100MBps ethernet ports. MDIO is used to connect with
PHY chip. During boot, the of driver is checking the PHYID, it gets
all Fs. But after I comment the following lines:
//if ((phy_id & 0x1fffffff) == 0x1fffffff)
//    return NULL;
I can use my FCC ethernet normally after boot into console.
I checked that while boot, all the read bit from MDIO pin is 1, that
makes no TA bit, and no PHYID.
I'm wondering why is that happening.
