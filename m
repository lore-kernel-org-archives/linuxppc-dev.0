Date: Wed, 5 Jun 2002 12:22:18 +0100 (BST)
From: Leigh Brown <leigh@solinno.co.uk>
To: trini@kernel.crashing.org
Cc: geert@linux-m68k.org, <paulus@samba.org>, <p2@mind.be>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: S3 trio config
Message-ID: <Pine.LNX.4.44.0206051219160.11815-100000@micro.solinno.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This little patch allows it to compile (non-module) for me:

--- linuxppc_2_4_devel/drivers/video/S3triofb.c	Wed Jun  5 06:01:45 2002
+++ linuxppc_2_4_devel-240/drivers/video/S3triofb.c	Wed Jun  5 10:00:01 2002
@@ -851,4 +851,4 @@
 module_init(s3triofb_init);
 MODULE_LICENSE("GPL");
 #endif
-module_exit(s3trio_exit);
+module_exit(s3triofb_exit);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
