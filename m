Message-ID: <001d01c20795$86b62240$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "MirekP" <ntr_stukacz@poczta.onet.pl>
Subject: Dram is not good on FADS860T board!
Date: Thu, 30 May 2002 12:50:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    Recently I want to run linux on FADS860T board,but i find thd DRAM of board can not work normally.
when I usr tftp translate file into 100000 (which is in DRAM) then usr IMI to check the image,it tell
BAD CRC, but I tftp 600000(which is in SDRAM) it told me check sum OK.sometimes I use MTEST to test DRAM
it also told me error .So i think must my DRAM is not good.Should I must setup some parameter use MPC8BUG?
Anyone can tell me ,i will apreciage very much! My DRAM simm is tosiba G3108 not motorola. what should i do?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
