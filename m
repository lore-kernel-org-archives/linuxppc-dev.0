Message-Id: <s84fbf1f.064@mail.frequentis.com>
Date: Thu, 09 Dec 1999 14:38:34 +0100
From: "Ralf HECKHAUSEN" <RHeckhau@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel configuration problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am using an MPC860 board with an c't69000 VGA controller on it. I would like to try out the kernel frame buffer driver for the c't65550 chip, as it should be quite compatible to ours. 
When I select the frame buffer option, I get an unresolved reference error (video_setup) in main.o. The only thing to get arround this is to chose the Virtual Terminal option. But then I get an unresolved reference error (request_irq) in pc_keyb.o. Im am using the kernel 2.2.5. Isn't there a way just to use the frambuffer without console and keyboard?

Thanks,
Ralf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
