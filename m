Message-ID: <37E4532D.45BA7203@insu.com>
Date: Sat, 18 Sep 1999 23:06:21 -0400
From: "Francis J. Lacoste" <francis@insu.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.X MACE driver broken on the PowerMac 7200.
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just upgraded to LinuxPPC R5 from something that 
approximates R3. (Kernel 2.1.24) I didn't really upgrade, 
but more start from scratch.  The builtin ethernet
card (MACE as you know) was working fine before the 
upgrade since I did a backup over the LAN to my main Intel
linux box before the upgrade. 

I wasn't able to use NFS or FTP for the upgrade, but resort
to a CDROM install. After the install, I realized that the
ethernet card wasn't working properly.  DHCP works fine
but nothing else works. If can grab an IP any time I want
with pump, but ping doesn't work. 

If I look at ifconfig, I see that there are a lot of dropped
packets plus some errors and some frames errors. I tried this
with kernel 2.2.6 and 2.2.12 both with booting with Open Firmware
or booting with BootX. 

I have no networking problem in MacOS. 

One other person has contacted me with an identical problem.

I also know that the card transmits the packets fine since
I see them  reach the Intel box when I run tcpdump on that
one. So it seems like its a receive problem.

I looked into the MACE driver source code, but there is not
any changelog, so I have no clue as where this may have break.

Does anyone knows what have changed between 2.1.24 and 2.2.X 
in the MACE driver (or in other part of the kernel) that may
have broken the receive part of the driver. 

I am willing to help debug this driver, but I will need some
pointer and clue since I am no expert kernel hacker.  And I
am much less familiar with the PPC port. Where
do I start to look ?  

Thanks for your insights.


P.S. Since I am not subscribed to the linuxppc-dev list, could
you please CC me replies.

-- 
Francis J. Lacoste		     iNsu Innovations Inc.	
Vice-Président développement 	      Tél.: (514) 336-5544
francis.lacoste@iNsu.COM	      Fax.: (514) 336-8128

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
