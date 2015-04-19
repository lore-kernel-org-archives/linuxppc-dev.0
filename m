Return-Path: <kiran1677@gmail.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E5761A0BC5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 17:50:37 +1000 (AEST)
Received: by qgdy78 with SMTP id y78so39912244qgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 00:50:35 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 19 Apr 2015 13:20:34 +0530
Message-ID: <CAPbBx=5chsiOxT+GiEX19At6p-pCaa7GckZFUPYo-7YGuphN2g@mail.gmail.com>
Subject: Regarding storing and parsing in Uboot
From: Kiran Kumar <kiran1677@gmail.com>
To: linuxppc-embedded-confirm+7f24a11fc6fcc59e94e351a947756ea5a83eabaf@ozlabs.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001a1147a37e8a8ee605140f1137
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1147a37e8a8ee605140f1137
Content-Type: text/plain; charset=UTF-8

Hello team,

I have a problem.

In uboot, i run some IPMI commands and I have to store that value in uboot
and also extract the interim byte of the output value.

I dont see the support for the same in Uboot or I'm missing something.

eg:

uboot> run <IPMIcmd>
The output of this has to be stored in some variable of Uboot, which I'm
unable to do.

Output of above step would be something like this: b1 87 98 76 *90 *87 00 91
I have to extract the value '*90*' out of it and do some oprations

Your help is much appreciated

regards,
Kiran

--001a1147a37e8a8ee605140f1137
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hello team,<br><br=
></div>I have a problem.<br><br></div>In
 uboot, i run some IPMI commands and I have to store that value in uboot
 and also extract the interim byte of the output value.<br><br></div>I dont=
 see the support for the same in Uboot or I&#39;m missing something.<br><br=
></div>eg: <br><br>uboot&gt; run &lt;IPMIcmd&gt; <br>The output of this has=
 to be stored in some variable of Uboot, which I&#39;m unable to do.<br><br=
></div>Output of above step would be something like this: b1 87 98 76 <b>90=
 </b>87 00 91<br></div>I have to extract the value &#39;<b>90</b>&#39; out =
of it and do some oprations <br><br></div><div>Your help is much appreciate=
d<br><br></div>regards,<br></div>Kiran</div>

--001a1147a37e8a8ee605140f1137--
