Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <s0632321.003@EMAIL>
Date: Thu, 25 Mar 2004 18:21:06 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MC850 peripheral support in linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I would like to know from all your experiences, if the following works well in the Linux-ppc port for MC850

1) Does the I2C bus support in the kernel works for the internal I2C controller of MC850
2) Does the RTC support in the kernel (char driver) works for the internal RTC of MC850
3) Does the PCMCIA support in the kernel (IDE drivers)  works for the internal PCMCIA Socket controller of MC850

I could find these supports in the latest ppc kernel. Since I don't have a hardware right now with me, so I am unable to test all these. I thought I will take all your help to confirm these facts.

This is to help me finalizing Linux for one of my Embedded Projects that will be built on MC850.





Thanks
--
Rupesh S


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
