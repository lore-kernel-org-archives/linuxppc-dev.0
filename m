Message-ID: <004a01bf50df$312fab80$70f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Help about device driver in Linux
Date: Tue, 28 Dec 1999 10:56:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, everyone

I want to make two device driver for MPC823,
one is for MPC823 Video, one is for MPC IIC.
Because in the Video driver, it must write configuration
parameters to the video controller through the IIC driver.

Question:
In the fuction cpm_823video_init(), can I call the cpm_823iic_write() ?
Otherwise, how can I do it?

Thanks in advacned!

BRs,
Shuangjun Zhu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
