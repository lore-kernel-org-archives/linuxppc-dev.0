Return-Path: <ganeshragavan@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 08651DDECC
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 03:16:15 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z74so4052945pyg
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:16:14 -0700 (PDT)
Message-ID: <8c6c6f450705291016j37b27003m646448b219db0717@mail.gmail.com>
Date: Tue, 29 May 2007 10:16:13 -0700
From: "Ganesh Ragavan" <ganeshragavan@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: jffs2 boot errors
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_105853_30414076.1180458973834"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_105853_30414076.1180458973834
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

We have been using PPC with a AMD flash (Spansion S29GL128M) on it for our
applications.  We are running Montavista linux on it.  Recently we replaced
the AMD flash with ST flash (M29W128FH).  The u-boot boots up and during the
kernel boot, I am getting the following error messages and the system
doesn't boot after this:


jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c:
0x2212 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000003c:
0x2212 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000040:
0x0020 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000005c:
0x2212 instead
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000060:
0x0020 instead

It would be really great if someone could let me know what is going wrong in
this.

Thanks,
Ganesh

------=_Part_105853_30414076.1180458973834
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><font face="Arial" size="2">Hi,</font></div>
<div>&nbsp;</div>
<div><font face="Arial" size="2">We have been using PPC with a AMD flash (Spansion S29GL128M) on it for our applications.&nbsp; We are running Montavista linux on it.&nbsp; Recently we replaced the AMD flash with ST flash (M29W128FH).&nbsp; The u-boot boots up and during the kernel boot, I am getting the following error messages and the system doesn&#39;t boot after this:
</font></div>
<div>&nbsp;</div><font face="Arial" size="2">
<div><br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000: 0x0020 instead<br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000001c: 0x2212 instead<br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000020: 0x0020 instead
<br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000003c: 0x2212 instead<br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000040: 0x0020 instead<br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000005c: 0x2212 instead
<br>jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000060: 0x0020 instead</div>
<div>&nbsp;</div>
<div>It would be really great if someone could let me know what is going wrong in this.</div>
<div>&nbsp;</div>
<div>Thanks,<br>Ganesh</div></font>
<div><font face="Arial" size="2"></font>&nbsp;</div>

------=_Part_105853_30414076.1180458973834--
