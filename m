Message-ID: <20020323001619.37875.qmail@web9506.mail.yahoo.com>
Date: Fri, 22 Mar 2002 16:16:19 -0800 (PST)
From: Subhachandra Chandra <subhachandra@yahoo.com>
Subject: Does Linux have a problem with the mfspr(BAT) bug on the 750FX
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi,
        The Errata document for the IBM 750FX
 processor
 Revision DD2.x says that the mfspr instruction has a
 bug when transferring data from a BAT register to a
 GPR register. It will transfer incorrect data.

   I did a text search through the Linux 2.4.17 kernel
code and did not find any place where mfspr is used to
move the contents of a BAT reg to a GPR (mtspr is used
but that works correctly). Does anyone know if I might
have missed something in the text search or any other
reason this bug could cause a problem while using
Linux on the 750FX processor.

Thanks
Subhachandra Chandra


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
