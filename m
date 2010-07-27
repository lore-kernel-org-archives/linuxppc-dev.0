Return-Path: <rick.ramstetter@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 5F8B8B70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 12:52:15 +1000 (EST)
Received: by wyb42 with SMTP id 42so2617023wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Jul 2010 19:52:12 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 26 Jul 2010 22:52:12 -0400
Message-ID: <AANLkTi=mAZOuyC4GmSUnk8d5gHs3N0NC2dhUH0K3jwUM@mail.gmail.com>
Subject: Where are logical memory block regions setup?
From: Rick Ramstetter <rick.ramstetter@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636833010851f7a048c5596f3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636833010851f7a048c5596f3
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

Where can I find the code that sets values in lmb.reserved.region[i]?
This is in reference to 2.6.27's arch/powerpc/mm/mem.c and
include/linux/lmb.h

I'm looking specifically for code that sets lmb_region's region.size and
region.base.

Thank you,
-Rick

-- 
J. Rick Ramstetter

--001636833010851f7a048c5596f3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Where can I find the code that sets values in lmb.reserved.r=
egion[i]? <br>This is in reference to 2.6.27&#39;s arch/powerpc/mm/mem.c an=
d include/linux/lmb.h<br><br>I&#39;m looking specifically for code that set=
s lmb_region&#39;s region.size and region.base.<br>
<br>Thank you,<br>-Rick<br clear=3D"all"><br>-- <br>J. Rick Ramstetter<br>

--001636833010851f7a048c5596f3--
