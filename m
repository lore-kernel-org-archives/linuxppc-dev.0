Message-ID: <00b201c0bd79$c4fa3bc0$8021690a@huawei.com>
From: "machael" <dony.he@huawei.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Timeout when pinging with larger packages...
Date: Thu, 5 Apr 2001 10:40:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

        Now I can run linuxppc-2.4.3-pre4 (from ftp.denx.de) on my
8260-based custom board sucessfully .
       I met a strange problem when ping this target board. When pinging the
board from my host using "ping -f  MyBoardIP " ,   it works normally. But if
I ping using "ping -s 200 MyBoardIP", then I can receive no respondence but
"TIMEOUT". Why?
       Do you have such similar problems? What may be the problem?

       Thank you very much!

       machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
