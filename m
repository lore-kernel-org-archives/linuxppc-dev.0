Date: Mon, 19 Jul 1999 20:18:09 +0200
From: Lucas Vergnettes <lucas@promac.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: TurboMouse support in standard trees
Message-ID: <19990719201809.A522@promac.org>
References: <199907180459.XAA31988@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199907180459.XAA31988@lists.linuxppc.org>; from Linux PPC Developer Digest on sam, jui 17, 1999 at 11:59:21 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I went to compile linus' kernel 2.2.10 today. I was using the paul's 2.2.1
realease before.

It looks like support for the turbomouse has gone :/
I know that Benjamin made some changes to the driver, but it looks like they
weren't adequate for the TurboMouse5.

After digging in the kernel messages, I found that the working kernel (2.2.1)
prints at startup : 

ADB mouse at 3, handler 1 (TurboMouse 5)
ADB mouse at 15, handler 1
ADB keyboard at 2, handler set to 3

while the 2.2.10 (not working) prints :

ADB keyboard at 2, handler set to 5
ADB mouse at 3, handler 1
ADB mouse at 15, handler set to 4 (TurboMouse 5)

I remember hearing some stuff about this trackball having 2 adb adresses
(which is shown), and needed to be passed a specific handler.

Unfortunately, I dunno anything about C :/

So Benjamin or other, if you read me, please help, I'm ready to do
Beta-testing and crashing for having this *finally* working everywhere!


Thanks
Lucas 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
