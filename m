Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id E0487DDF82
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 00:41:48 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so6363ywt.39
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 07:41:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A09234E.4020401@dlasys.net>
References: <4A09234E.4020401@dlasys.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 May 2009 08:41:27 -0600
Message-ID: <fa686aa40905120741w791e4bcbybd4024e051ab2a88@mail.gmail.com>
Subject: Re: Xilinx FIFO TEMAC !?
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 1:20 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrot=
e:
> =A0 =A0 =A0 Anyway is there any interest in an LL FIFO TEMAC driver ?
> =A0 =A0 =A0 Or adding the FIFO code to the SDMA TEMAC code ? It only adds=
 a
> couple of dozen lines to the driver.

yes to both.

BTW, when discussing the lltemac driver, you should cc: both the
linuxppc-dev and the netdev mailing lists.  You should also cc: me,
otherwise I might not see it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
