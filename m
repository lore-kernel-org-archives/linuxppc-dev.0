Message-ID: <007101bff8fa$5c713a20$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "Linux PPC Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: Can I debug interrupt under PPCbug?
Date: Sat, 29 Jul 2000 09:14:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:
  I'm debugging my program on MVME2600 using PPCBug. I have mapped all the
memory which will be used by PPCBug 1:1 using PTE . Normal program can be
debugged now. But can I debug my interrupt processing program such as
Decrementer Exception?
  It seems that 'rfi' instruction can't be used under PPCbug. Am I right?








Gong Zhuo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
