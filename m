Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <00a101c401d4$26140fc0$0400a8c0@portatile>
Reply-To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: "mkimage" not found
Date: Thu, 4 Mar 2004 11:33:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have just downloaded the new ELDK 3.0 installed and compiled for the
EST8260 board.

With the previous ELDK2.0 I would have generated the image with the "make
pImage" command while now I suppose the command "make uImage" must be used.
Is this correct?

Then at the end of compilation process, I have the following message:
"mkimage" not found - U-boot Images will not be built.
I have checked the presence of mkimage as executable file (which exist
because prior to compile the linux tree I have generate the U-boot
executable) and its functionality (by calling it directly without script).
Anybody has an idea where I am wrong?

Thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
