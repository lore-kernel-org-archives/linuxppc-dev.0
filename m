Date: Wed, 30 Jun 2004 09:31:04 +0200
From: Massimiliano Zilio <massimiliano.z@tiscali.it>
Subject: gdb with stbx25xx runs ONLY IN STEP BY STEP mode
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <40E26C38.5040205@tiscali.it>
MIME-version: 1.0
Content-type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
     we are trying to debug an application on gdb + wiggler + stbx25xx.
This application runs under gdb control but unfortunately it runs only
step by step.
If I give "continue" command  the execution doesn't continue and next
istruction is not executed.
If I set a breakpoint, it can't continue the execution trought it any
more, neither step by step.  I must remove it if I want coninue.

Have you ever seen this kind of problem?
Have you got any suggestions?

Thanks for your help.
Bye Max


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
