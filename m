Message-ID: <004b01c00297$9016bb60$260102c8@sc.mcel.mot.com>
From: "Li Guangdong" <a16164@email.mot.com>
To: "PPC mail list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Segmentation fault
Date: Thu, 10 Aug 2000 14:52:34 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,


When we run a GUI program on Hard Hat Linux(CDK1.0) on RPX-lite, it always
crashes with the message "Segmentation fault" or "Aborted" on the console
after manipulating the GUI windows for some time. It seems that something
wrong with the malloc() and free() functions.

And we found that, if malloc() (or __libc_malloc) is called continuously, it
seems OK. But if malloc() is called after freeing some previously allocated
blocks using free() (or __libc_free), we always get the message
"Segmentation fault".

By the way, this GUI program is built with g++ and "-static" option.

Could you please give your advice on this problem?

Thanks,
Kant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
