Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3FE6DCB3.109@catapult.com>
Date: Mon, 22 Dec 2003 06:59:47 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Boot Loader
References: <OJEPIMKHOKJAJIDJLJBNAEKLCAAA.jbates@paradise.co.uk>
In-Reply-To: <OJEPIMKHOKJAJIDJLJBNAEKLCAAA.jbates@paradise.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

For my end target I have to boot across a shared memory
interface by placing the executable into RAM.  This is
part of a multi processor system where the Linux board
is a cPCI slave.  The Linux board will not have a flash
or a network connection.  I is held in reset by the master
until the s/w is loaded and then released.  This is an 8275
target.  The "Master" is a Solaris Workstation or a PC
style Linux box or card.

Any suggestions on how to do this ?
Have to fill in my own board info in a bd_t struct,
pass it in R3, if I use and initrd it's start and end ptrs
go into R4, R5 and the cmd line params will
be hard coded and inserted into R6,R7...
I will be using a RAM disk for the root file system.

Instead of compressing and creating uImage for das u-boot,
I create a binary(?) image and just shove it into RAM at
0?  Ensure the Reset vec is set to my initialization code
that will be part of the download...

Any ideas would be appreciated.

Thank you
Kevin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
