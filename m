Date: 14 May 2003 14:36:24 -0000
Message-ID: <20030514143624.358.qmail@webmail31.rediffmail.com>
MIME-Version: 1.0
From: "ramanathan G A" <ramanathan_ga@rediffmail.com>
Reply-To: "ramanathan G A" <ramanathan_ga@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux ppc boot parameters R3, R5
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am trying to boot an MPC8260 board with Linux 2.4.4. I cross
compiled the kernel for PPC using GCC 3.2 and prepared a
'zImage.initrd'. Since the board has a working bootloader for
pSOS, I decide to use the same with minimum modifications to suite
for loading the linux image.

Going through the literature, I could understand that the linux
image is expecting TWO arguments; in registers R3 and R5.
R3 - Pointer to board information structure
R5 - Open Firmware Data. (??)

Now, I have to modify my boot loader in order to boot linux
image.
The boot loader is supposed to do the basic initialization of the
processor, load the image on to the RAM from flash and give
control to the image entry point.

Could some one help me giving pointers to what is meant by this R5
parameter (Open Firmware Data)? What is the significance? Can I
avoid this parameter and proceed?
(I am stuck at this point.)

Any suggestions to improve the situation is welcome.

Thank you.

Rgds,
Ramanathan G A


___________________________________________________
Impress your clients! Send mail from me @ mycompany.com .
Just Rs.1499/year.
Click http://www.rediffmailpro.com to know more.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
