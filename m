Message-Id: <200108301400.KAA09451@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MCP750 ROMBoot
Date: Thu, 30 Aug 2001 09:52:25 -0400
References: <85256AB8.000FA622.00@pine.cspi.com>
In-Reply-To: <85256AB8.000FA622.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I saw this during a flurry of work on MVME2400 and MVME5100 boards. I can't
tell you if it was a kernel version problem or a config problem, but it has
since gone away. Go through your .config with a FINE tooth comb and make sure
everything looks good. Then try a different kernel version. Oh also just make
sure you are using the correct boot image and are flashing the whole image! I
have gotten bit by the copy and paste bug where my kernel size changed and I
stopped FLASHing the whole image.
Just a few thoughts.


On Wednesday 29 August 2001 10:50 pm, you wrote:
I use MCP750,linuxppc_2_4 from penguinppc. I rebuild the kernel,and can
boot the board via NFS correctly. But when I fill kernel in Bank
A(ff000000,onboard flash) and use ROMBoot, it appears:

Linux/PPC load: root=nfs rw ip=on
Uncompressing Linux...inflate returned FFFFFFFD
exit

my kernel is about 840k,is it too big?

I realy thank the mailing list and the person who answer me.They give me
great help.
--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
