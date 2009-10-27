Return-Path: <luigi.mantellini.ml@gmail.com>
Received: from mail-bw0-f219.google.com (mail-bw0-f219.google.com
	[209.85.218.219]) by ozlabs.org (Postfix) with ESMTP id 85501B7BEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 02:27:13 +1100 (EST)
Received: by bwz19 with SMTP id 19so323256bwz.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 08:27:10 -0700 (PDT)
From: "Luigi 'Comio' Mantellini" <luigi.mantellini.ml@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Low BogoMips
Date: Tue, 27 Oct 2009 16:27:06 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200910271627.06549.luigi.mantellini.ml@gmail.com>
Reply-To: luigi.mantellini.ml@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

my name is Luigi. I'm working on a stripped-down mpc8541 board (that has just 
a serian and twe enets).
I have an issue on delay calibration. In fact my at boot time I see the 
following on the serial console:

....
Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
....

This value seems to be too low and I suspect an error propagated from u-boot.

Can anyone help me to understand a good way to investigate this problem? which 
registers or configuration values I need to check?

I will post the necessary snips of code or configuration if required.

Thanks a lot for your help,

ciao

luigi

-- 
Luigi 'Comio' Mantellini

R&D - Software
Industrie Dial Face S.p.A.
Via Canzo, 4
20068 Peschiera Borromeo (MI), Italy
Tel.:  +39 02 5167 2813
Fax:   +39 02 5167 2459
Email: luigi.mantellini@idf-hit.com
