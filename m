Message-ID: <38B5D770.4E51604E@huawei.com.cn>
Date: Fri, 25 Feb 2000 09:14:25 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: How to get a mini libraries for my embed linux application?
Content-Type: multipart/mixed;
 boundary="------------E409B52B8D9CEBCF4FCE42CC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------E409B52B8D9CEBCF4FCE42CC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, everyone:
     Since my flash is only about 2M. I am fear that there will be not
enough space to hold everything  including kernel and filesystem in my
flash in the final product. I think the share libraries will play an
important role in reducing the total size. So my questions is:
     How to get a mini libraries for my embed linux application?
Modifying the glibc packages is really an annoying thing. what 's the
alternative methods?
     dony

--------------E409B52B8D9CEBCF4FCE42CC
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Received: from lists.linuxppc.org ([169.207.161.3]) by mail.huawei.com.cn
          (Netscape Mail Server v2.02) with SMTP id AAA23892
          for <dony.he@huawei.com.cn>; Thu, 24 Feb 2000 20:03:26 +0800
Received: from localhost (majordomo@localhost)
	by lists.linuxppc.org (8.9.1a/8.9.1) with ESMTP id GAA20956;
	Thu, 24 Feb 2000 06:01:19 -0600
Received: by lists.linuxppc.org (TLB v0.11a (1.26 tibbs 1998/09/22 04:41:41)); Thu, 24 Feb 2000 06:01:13 -0600 (CST)
From: Ruedi.Hofer@ascom.ch
Date: Thu, 24 Feb 2000 12:59:28 +0100 (CET)
Subject: Re: LinuxPPC2000 on MPC860
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FQF00LG1O1J7P@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_DUYgDvvMdgW2CgSDu+5VNQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
Precedence: bulk
X-Mailing-List: <linuxppc-embedded@lists.linuxppc.org>
X-Loop: linuxppc-embedded@lists.linuxppc.org
X-Mozilla-Status2: 00000000



--Boundary_(ID_DUYgDvvMdgW2CgSDu+5VNQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Some further info.

I'm right now using the ramdisk.image.gz from the LinuxPPC-2000-lite cdrom
as nfs mounted rootdisk. (I installed the ramdisk on the PC)

Like that I get an error message right after the kernel has booted:

>...
>Looking up port of RPC 100003/2 on 10.1.20.2
>Looking up port of RPC 100005/1 on 10.1.20.2
>VFS: Mounted root (NFS filesystem) readonly.
>Freeing unused kernel memory: 32k init
>tty_io.c: process 1 (swapper) used obsolete /dev/cua0 - update software to use /dev/ttyS0

I found out that the kernel generates this error message in drivers/char/tty_io.c .

Does someone know what this error message means? How to avoid it?

TIA, Ruedi



--Boundary_(ID_DUYgDvvMdgW2CgSDu+5VNQ)--



--------------E409B52B8D9CEBCF4FCE42CC--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
