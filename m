Date: Thu, 6 Nov 2003 21:24:45 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] incorrect function declaration for claim()
Message-ID: <20031106202445.GA6293@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


its void * in start.c


--- linux-2.4/arch/ppc/boot/chrp/main.c~	2003-07-17 19:28:11.000000000 +0200
+++ linux-2.4/arch/ppc/boot/chrp/main.c	2003-11-06 21:21:26.000000000 +0100
@@ -17,7 +17,7 @@ extern char _start, _end;

 extern int getprop(void *, const char *, void *, int);
 extern unsigned int heap_max;
-extern void claim(unsigned int virt, unsigned int size, unsigned int align);
+extern void *claim(unsigned int virt, unsigned int size, unsigned int align);
 extern void *finddevice(const char *);
 extern void flush_cache(void *, unsigned long);
 extern void gunzip(void *, int, unsigned char *, int *);


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
