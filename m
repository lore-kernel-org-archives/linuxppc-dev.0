Date: Sun, 11 Jun 2000 15:36:37 -0400
From: Alain Birtz <abz@videotron.ca>
Subject: What is asmlinkage ?
To: linuxppc-dev@lists.linuxppc.org
Reply-to: abz@videotron.ca
Message-id: <3943EA46.F7B10185@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; x-mac-creator=4D4F5353; x-mac-type=54455854; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In /linux/shm.h there are many "asmlinkage" declaration like

asmlinkage int sys_shmat();

The source code for it is /linux/ipc/shm.c (and object file is
/linux/ipc/shm.o)
I wish to use sys_shmat() in a module: how can I do this ?

Thank you.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
