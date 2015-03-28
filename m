Return-Path: <olaf@aepfle.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD0C41A0259
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 01:08:12 +1100 (AEDT)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 95F2D1400DE
 for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2015 01:08:10 +1100 (AEDT)
Received: from probook.fritz.box ([2001:a60:1085:1c01:1ec1:deff:feb9:bb48])
 by smtp.strato.de (RZmta 37.4 AUTH) with ESMTPSA id e02a71r2SDsnwnj
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256))
 (Client did not present a certificate) for <linuxppc-dev@ozlabs.org>;
 Sat, 28 Mar 2015 14:54:49 +0100 (CET)
Date: Sat, 28 Mar 2015 14:54:49 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: nouveau regression on G5 Dual Core
Message-ID: <20150328135449.GA29661@aepfle.de>
References: <20150328125916.GA29649@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150328125916.GA29649@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 28, Olaf Hering wrote:

> I just updated the kernel from some 3.18 based state to 4.0-rc5+. The

3.19 is already broken, will bisect next week.

Olaf
