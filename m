Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000901c09fe8$def06760$8021690a@huawei.com>
From: "dony" <dony.he@huawei.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20010222074732.6B566281D9@denx.denx.de>
Subject: Which board use 8260 CPU?
Date: Mon, 26 Feb 2001 19:40:08 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

    I just downloaded ppcboot.tar.gz files.
   Since my custom board use 8260, I want to find a board  using 8260 from ppcboot/board as a example.  I know "cogent"  board supports 8260, but it seems to be a little complex for me.
Are there other boards using  8260 CPU which can meet the following requirements:
 1  Initialize CPU core registers , SDRAM, MMU,SIU, CPM
 2  Initialize Serial Port and Network (SMC , FCC).
3  Download kernel from tftp server or load kernel from on-board flash ?

Thank you very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
