Message-ID: <E1836A7F3557D311A14000805F9F36FC01518848@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: parse error before `i2c_rpx_exit'
Date: Wed, 13 Feb 2002 17:15:56 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I am using HHL 1.2 Linux Kernel version 2.2.14 on an Embedded
Planet MPC823e platform. When attempting to integrate my PPC
kernel with I2C-2.6.2 I get the following error:
  i2c-rpx.c:123: parse error before `i2c_rpx_exit'
  i2c-rpx.c:124: warning: return-type defaults to `int'
  i2c-rpx.c: In function `i2c_rpx_exit':
  i2c-rpx.c:126: warning: control reaches end of non-void function

The offending lines of code in i2c-rpx.c are:
  void __exit i2c_rpx_exit(void)
  {
        i2c_8xx_del_bus(&rpx_ops);
  }

What could be causing this error? Everything looks OK to me.

Regards,
     Michael Pergola
     Software Engineer
     Danfoss Air-Conditioning & Refrigeration Division
     7941 Corporate Blvd.
     Baltimore, MD  21236     (410) 931-6778 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
