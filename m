Message-ID: <BB30349BF3FE18418DC420BDDCAE22AF0144AC0D@az33exm54.corp.mot.com>
From: Xiao Xianghua-r6aads <X.Xiao@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Motorola I2C driver consolidation?
Date: Thu, 23 Oct 2003 08:50:09 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm in preparation to release a Linux I2C driver for Motorola PowerQUICC III(8540/8560). In fact, all MPC8240/MPC8241/MPC8245/MPC8540/MPC8560/MPC107 have the same I2C block so it makes sense to have one driver works for all. Currently there are a few of them, including Michael Primm's 8245 I2C driver, Adrain Cox's MPC107 I2C driver, Wolfgang Denk's MPC8240 I2C driver, and my MPC8540/8560 I2C driver. I'm communicating with all the authors and the I2C team(lmsensor) on how to get one unified I2C driver to the kernel as soon as possible.

My question is that should I send a patch to the PPC maintainer or the I2C lmsensor team, or both?

Motorola chips do provide another I2C block, which is CPM-based. Again it makes sense to have a second unified driver works for all CPM blocks(i.e. 8xx, 82xx,etc). Currently there is a 8xx I2C driver in the kernel and I wonder if there is any existing i2c patches for 82xx(8260,8265,827x,828x,etc) as well?

thanks,

xianghua

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
