Message-ID: <20020904111431.7570.qmail@sina.com>
From: wdfhym <wdfhym@sina.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: A question about FEC on MPC860T
MIME-Version: 1.0
Date: Wed, 04 Sep 2002 19:14:31 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear sir:
I am in china.During my writting a driver for the FEC on the MPC860T board,I do not know how to configure the LXT970 PHY. The connections of pins are designed as following:
860T's port D pins are connected to LXT970's pins according to the user manual. 860T's port B pins are used as:PB15 to LXT970's CFG0,PB16 to CFG1,PB17 to LXT970's,FDE,PB18 to LXT970's RESET.In addition,The PC7 of 860's port C is connected to LXT970's TRSTE.
My version of embedded linux is 2.2.13 and the driver for fec is the file fec.c located in ./linux/arch/ppc/8xx_io.I have read fec.c carefully.I found that only the port D is set,but port B and port C are not set.
Could you help me to finish configuring the port B and C in fec.c?
Thank you very much.
Dafu wu
2002.09.04



______________________________________

===================================================================
新浪免费电子邮箱 (http://mail.sina.com.cn)
新浪分类信息：二手市场走一走，该出手时就出手！ (http://classad.sina.com.cn/2shou/)
数万张手机图片数万首短信铃声任你挑选，每天都有更新 (http://sms.sina.com.cn/cgi-bin/sms/smspic.cgi)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
