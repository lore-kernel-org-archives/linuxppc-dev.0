Message-ID: <3E9F440A.52FE7459@cs.fujitsu.co.jp>
Date: Fri, 18 Apr 2003 09:17:14 +0900
From: Takeharu KATO <tkato@cs.fujitsu.co.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Task tsruct relevant question
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear maintainers:

I have a queestion about task_struct relevant issue.
As far as I know, task_structs in kernel 2.5.X are placed in
slab cache. But they are placed on kernel stack on linux-2.4.67
for PPC4xx.
Is it correct in linuxppc branch?
Does any one have a plan to move them into slab cache down the line?


--
Takeharu KATO
Fujitsu Limited
Email:tkato@cs.fujitsu.co.jp (ext. 7112-4621)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
