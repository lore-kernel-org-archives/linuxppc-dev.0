Return-Path: <curieux.khetan@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 26E3D140086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 21:35:29 +1100 (EST)
Received: by mail-pa0-f41.google.com with SMTP id fa1so3307013pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 03:35:25 -0700 (PDT)
Message-ID: <5333FEBD.3050704@gmail.com>
Date: Thu, 27 Mar 2014 16:04:37 +0530
From: Ashish <curieux.khetan@gmail.com>
MIME-Version: 1.0
To: kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: MPC8641 based custom board Kernel stuck at 1000Mhz core clock
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
 <52BBF1CB.3070006@gmail.com>
 <CAERE9Prr_C31D96zuYbV0KQ7b_j8Te0A2DO8C+6YtetF0e6M_w@mail.gmail.com>
 <CALyraeMiKQsoHV8AQ5SOz926z_YBD3LbFFNefMpRibYOt=Vo=Q@mail.gmail.com>
 <CAERE9PrX61oNtQoT1tpL_+rXfirFeMa4woD2P2TSUJ_Xj-h4rg@mail.gmail.com>
In-Reply-To: <CAERE9PrX61oNtQoT1tpL_+rXfirFeMa4woD2P2TSUJ_Xj-h4rg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

  I am using MPC8641-HPCN based custom board and able to boot linux at 
MPX clock 400Mhz and core clock 800mhz. When I am increasing core 
frequency ie MPX clock at 400Mhz and core at 1Ghz, kernel stuck. Does 
any body have faced this kind of issue ?  Or any idea how to resolve this?





Thanks & Regards

A$hi$h
