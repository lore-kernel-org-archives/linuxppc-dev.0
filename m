From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Memory management problem with RAMDISK, any help?
Date: Tue, 18 May 2004 11:51:24 -0400
Message-ID: <000e01c43cef$f9180dd0$45a97241@Yongkoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <40AA2542.5060306@egholm-nielsen.dk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 My Linux (v.2.4.22) running on a PowerPC 750 system does not seem to know
the memory bound when ramdisk is installed. The system has 128 M memory and
28 Meg of the memory is used as ramdisk. I setup the memory size as 128M
bytes at the kernel parameter and ppc_md.find_end_of_memory() routine
returns constant 128M.

  The kernel dies with " Oops: kernel access of bad area, sig: 11".
The area it accessed is the start of the last 28 Megabytes of the 128 M
memory. It happens when the kernel tries to allocate memory for socket
communication.

 How can I know the kernel knows the end of memory correctly?
Could it be other problem?

 Thanks,

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
