Message-Id: <199812270305.LAA25928@mule.wantree.com.au>
Subject: Cannot boot with 2.1.13x kernels
Date: Sun, 27 Dec 1998 13:31:05 -0000
From: Keith Jacob <kjacob@wantree.com.au>
To: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Now that I have BootX working reliably (one more vote for "Best App in 
'98"), and confirmation that my setup can produce bootable kernels 
(2.1.24 and 2.1.127), I would very much appreciate some feedback on why 
2.1.130 from Samba and 2.1.132 (with Tom Rini's patch) from kernel.org 
won't boot this 7200/75.

I configured in the BootX early text console code, and get the message at 
the top of the screen as expected, but the boot does not proceed.

Since my no-boot probs are definitely post-2.1.127, and compilations take 
"a while", it would be nice to get some ideas on what is going wrong 
before I try compiling any newer kernels.

Talking completely out of the side of my head, could this be a Platinum 
(7200 display) issue? I'm led to this conclusion by the "lucky dip" 
experiences I get with 2.1.127: using platinumfb, 832x624 only works at 
8bpp, and colours are wrong in 640x480 above 8bpp, with no console 
"screen saver" at any res (only the cursor disappears); with BootX's "No 
video driver" checked, 832x624 works at "Millions", incl. Xpmac, the 
console screen saver works, but graphics performance is a tad slower 
(probably to be expected, I guess).

Of note, the pre-compiled 2.1.130 at samba.anu.edu.au/pub/linux-pmac does 
not boot either: that is a first for me.

I want to help with the Platinum driver, but need to solve my kernel 
probs first, so please send any suggestions.

TIA

--
Keith Jacob
kjacob@wantree.com.au




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
