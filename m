Message-ID: <20010117133223.25513.qmail@web3001.mail.yahoo.com>
Date: Wed, 17 Jan 2001 05:32:23 -0800 (PST)
From: Rajesh S <srj102@yahoo.com>
Subject: Linux Kernel restart
To: linuxppc-embedded@lists.linuxppc.org
Cc: srj102@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

1)  Is there a way how we can launch the linux kernel
 alone(from linux) without having to go to the
 System Reset Vector etc .. I want to avoid
 all processor initializations

2) How does the shutdown command ultimately achieve
   the reboot... Where can I fnd the code ?
   I have the sysvinit source code distributoin
   from hard-hat and I can see that init_reboot()
   maps to reboot(magic) .. Then I lose track..


Thanks in advance,
Rajesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
