Message-ID: <19990817144835.7429.rocketmail@web601.yahoomail.com>
Date: Tue, 17 Aug 1999 16:48:35 +0200 (CEST)
From: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
Subject: linuxppc for MPC860
To: linux linuxppc dev <linuxppc-dev@lists.linuxppc.org>,
        linux linuxppc user <linuxppc-user@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Dear PPC People,

I'm a student working this time in Matra SI, in the electronic section.
I want to run linuxppc on a custom MPC860 PowerQuiccMH board with:

       *64 Mo DRAM
       *4 Mo FLASH ROM
       *Ethernet is supported on SCC1
       *a serial port on the SCC4

I'm working on a PII 400 computer with the linux-2.2.10 release.
My cross compiler is gcc-2.7.x and I found an embedded-2.2.5 directory
on the net (for the linuxppc sources) but I have some problem with the
compilation.

I want to import also a linuxppc kernel release on my board, and after
create a serveur (ethernet, video and internet if necessary) from this
board.

I'm not sure which way I must follow:

       - Create a minimal root file system (on the                     
      flash memory) for after booting the embedded                     
      board with linux (must I write a bootloader                      
     and configure the flash ?)

       - Booting (via ethernet or another protocole)                   
        with a precompiled linuxppc kernel.

I's that correct? If yes could you tell me please how I must process or
if you have another easier solution?

I didn't seen the configuration scripts modified (for compiling the
kernel) for MPC860 on the .config and makefile; have you worked on this
subject recently?
 
Thanks for your help and Have a good Day.
Sébastien Tadéoni.



Votre e-mail @yahoo.fr gratuit sur http://courrier.yahoo.fr


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
