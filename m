Message-ID: <19990917161450.229.qmail@nwcst268.netaddress.usa.net>
Date: 17 Sep 99 11:14:50 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Boot Methods Debate
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My two-cents, go with the best available option for each architecture and have
the OS installer set up booting appropriately. Here is an example for a OF
PowerMac using a RedHat style installer.

->Load RedHat Installer (Yellow, LPPC, Turbo, etc)
->Installer detects/asks what machine Im using (I select Beige DT G3)
->Installer sets up my partitions and saves data to vars
->Installer sets up video and saves data to vars
->Installer asks what my default OS should be (I select Linux)
->Installer applies all OF patches necessary and uses partition/video vars to
set up boot options
->reboot into linux

I believe this is achievable since all the OF patches are "open" as ben
pointed out. Of course, if I select a compatible Nubus Mac, the installer
would set up miBoot. 

Of course, if I was a distributor, I would just go with whatever worked most
reliably and consistently; programming paradigms and boot theories aside.


Jeramy B Smith
jsmith@penguinPPC.org
http://penguinPPC.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
