From: jonb@marel.is
Subject: 823e LCD display - Microwindows
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFFAB81681.9CA422F8-ON00256968.00595E55@marel.is>
Date: Thu, 28 Sep 2000 16:46:14 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have now successfully gotten Linux running on a custom 823e board,
using Monta Vista CDK 1.2, Linux version 2.2.14.  I am using an NFS
root file system and I have created a custom lsp for the board.

Our board uses the 823 LCD controller for a 640x480 TFT display.

I would like to activate the 823 LCD driver and try out the Microwindows
demo from Monta Vista, but I do not know what needs to be done.

When I configure the kernel with CONFIG_RPXLCD, I get a lot of
undefined symbols when linking the kernel, such as fb_display,
fb_default_cmap.

Can anyone point me in the right direction ?

Regards,

Jon Benediktsson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
