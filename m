Message-ID: <020e01bfc93f$5dc075c0$db52df8d@helsinki>
From: "SangTae Ha" <stha@postech.edu>
To: "Rodney Davies" <rodneyd@nulec.com.au>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Do you have your minimum ramdisk image which can provide basic network services ?
Date: Mon, 29 May 2000 16:27:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I want to make my ramdisk image which can provide basic network services such as "ping","traceroute","telnet" and "ftp". I want to reduce my file size within (1or2)M bytes. I already downloaded full image file at ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/mbxroot.full.tgz
This file is so big including all of things. I am currently pruning various directories and files in it. I hope that it doesn't take too much time.
I have two choices.
1) compile the LRP(Linux Router Project) package and make it into root file system image
2) reducing file size from full image file and make final small size image

How do you think about above solutions?

I just want to use TCP/IP networking facilities. I will really be happy if you already got that image..

Thank you for your help


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
