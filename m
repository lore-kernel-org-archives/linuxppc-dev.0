Message-ID: <002301c1450d$10b87520$9bca8a89@cern.ch>
From: "Shoudong XU" <Shoudong.XU@cern.ch>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: unresolved symbol
Date: Mon, 24 Sep 2001 17:24:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all.

    I'm running a Spruce board with NFS mode(load kernel image by tftp, then mount nfs as it's root file system), but When attempting to insert a module manually(/sbin/insmod xx.o), I get messages like:
    xx.o    unresolved symbol     unregister_chrdev
    xx.o    unresolved symbol     register_chrdev
    xx.o    unresolved symbol     __get_free_pages
    ...
    xx.o    unresolved symbol     printk

    And all those symbols are present in /boot/System.map, it seems this file is useless.

    Could you give me some advice?

Thanks

Shoudong

----------------------------------------------------------
 Shoudong XU             Email:  Shoudong.Xu@cern.ch
 CERN, EP Division       Tel:    +41.22.767-8113
 CH-1211 GENEVE 23       Fax:    +41.22.767-7793
 SUISSE/SWITZERLAND
-----------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
