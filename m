Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0BAD1A07BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 00:17:38 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [P.A. Semi] Does the ethernet interface work on your Electra, Chitra,
 Nemo, and Athena board?
Message-ID: <565AF986.9060106@xenosoft.de>
Date: Sun, 29 Nov 2015 14:11:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Does the ethernet interface on your Electra, Chitra, Nemo, and Athena 
board work with the release candidates of the kernel 4.4? Unfortunately 
the P.A. Semi ethernet doesn't work on our Nemo boards with the release 
candidates of the kernel 4.4. We have set the following entries in the 
kernel config:

CONFIG_NET_VENDOR_PASEMI=y
CONFIG_PASEMI_MAC=y

Could you please test the P.A. Semi ethernet on your P.A. Semi boards?

Thanks in advance,

Christian
