Date: Tue, 28 Mar 2000 10:49:40 -0500 (EST)
From: "Min Shin (CS)" <shin@csee.usf.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
In-Reply-To: <20000328115126.003377@mailhost.mipsys.com>
Message-ID: <Pine.GSO.4.05.10003281041030.24048-100000@grad>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not a Linux expert at all and I tried to download the files that you
have at ppclinux.apple.com/~benh.  But, I some difficulty setting  stuff
up.  So, I'll explain what I did, and perhaps you can give me a lift.
Then, I'll write it up and post it on the web on how to set it up for the
beginners. :)

* SETTING :
- Powerbook 400Mhz + 192MB RAM...
- Mac OS 9.0.2
- Attempt to use 1 harddrive to setup LinuxPPC2000.

* STEPS :
1.  partitioned the HD into three partititions: MacOS, Linux, Swap
2.  download the image file of LinuxPPC2000 from the mirror site and
placed it in the swap disk.
3.  using 'diskcopy", installed the linuxppc2000 image in the swap disk
	creating LinuxPPC 2000 install directory.
4.  downloaded the kernels from ppclinux.apple.com/~benh at swap disk
	vmlinux...
	system.map...
	modules...
	patches...

5.  downloaded yaboot from ppclinux.apple.com/~benh as well.
	-> to boot yaboot?
	- but I saw yaboot in Linuxppc2000 install directory as well.
	But reading the file, it seems as it's assuming to read boot file
		from CD rom.

6.  ran LinuxPPC installer.
7.  reboot, but it will go with BootX.

Would you tell me what are the other steps that I need to take?  Such as
where to place those four files, if I need to uncompress them...

Thanks


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
