Message-Id: <v02140b00b2a6453f1cd9@[209.157.72.95]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 22 Dec 1998 23:15:47 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>
From: daver@idiom.com (David Ray)
Subject: Re:Test kernels for chipsfb (2400/3400)
Cc: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:21 AM 12/23/98, Benjamin Herrenschmidt wrote:
> I've uploaded two test kernels at:
> 
> <http://calvaweb.calvacom.fr/bh40/vmlinux_test.gz>
> <http://calvaweb.calvacom.fr/bh40/vmlinux_test2.gz>


I just tested these 2 kernels on my Powerbook 2400. The first kernel (vmlinux_test.gz) worked perfectly in 8-bit and 16-bit mode, both in the console (run level 3) as well as in X.

The second kernel (vmlinux_test2.gz) worked in the console at both depths, but X failed to work in either depth. The screen went black. I had to use the key combination option-power to kill X.

These were both with the 2400/3400 enhanced version of X from inria.fr.

The XF86_FBDev from the recent 3.3.3 release fails to work on any kernel I have tried on my PB 2400, including 2.1.115, and 2.1.130. Somebody posted to the list on Dec 15 claiming that the amount of VRAM is hard coded into chipsfb.c and this value doesn't match the correct amount -- and this is why XF86_FBDev doesn't work on a PB 2400. They posted a patch to chipsfb.c that raised the VRAM that X thought it had. They they claimed fixed the problem with XF86_FBDev at least partially. I haven't had time yet to try that patch myself. I believe you can find a copy of that post in the archives.

-Dave

PS I'm off the list for a couple weeks during the holidays, so please copy me by personal email for any email/postings about the Chips 65550 issue. Thanks.




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
