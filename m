Message-ID: <000f01c24d3e$4fed5460$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Downloading Image
Date: Tue, 27 Aug 2002 01:52:34 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I have build a linux image for IBM PPC 440 using the
src-linuxppc_2_4_devel.tar.bz2 [Powerpc Kernel Source] taken from the
website http://www.ppckernel.org/tree.php?id=5. Now I want to download the
image to the IBM PPC 440 evalkit for which I used elf2ppceval utilility by
Grant Erickson.  I copied the script and named as mkevimg.shar. When I
executed the command  "unshar mkevimg.shar ". I got the following error

[root@hardhat aman]# unshar mkevimg.shar
/home/aman/mkevimg.shar:
'h: line 22: syntax error near unexpected token `do
'h: line 22: `do
Broken pipe


Can anyone help me in solving this issue or please suggest the way of
downloading a the 440 image to the IBM PPC 440 evalkit. Also can you suggest
me the cross-compiler for PPC 440.

Thanking you in advance.

Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
