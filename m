Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000701c2174c$1de38ac0$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: "MirekP" <ntr_stukacz@poczta.onet.pl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: All is OK!
Date: Wed, 19 Jun 2002 12:45:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    Good afternoon!
    Tell you a good message! I have solved the probelm!Now Linux 2.4.18 run on
My fads board quite well.thank you very much! you give me much help! I appreciate
you indeed!so i want to evryone know what i did.when you define CONFIG_CLOCKS_IN_MHZ=1,
you should update two place with MPC8xx board:
   1./arch/ppc/kernel/m8xx_setup.c line 141,
     you should multiple 1000000 with binfo->bi_intfreq.
   2./arch/ppc/kernel/8xx_io/commproc.c line 247
    should be :#define BRG_INT_CLK (((bd_t *) res)->bi_intfreq*1000000)
Ok,this is my experience, Hope nobody not to make mistake on this again.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
