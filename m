Message-ID: <38756CD1.1F000564@huawei.com.cn>
Date: Fri, 07 Jan 2000 12:34:25 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: decompress_kernel() questions...
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Now the bootloader can work. But when it enters into decompress_kernel(
)£¬It shows a
message " bad gzipped data " and exit. I trace the misc.c and find this
message is appeared in
gunzip(). I think it cannot locate the offset of the zipped kernel image
file. Do you have any
experience?
Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
