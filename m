Return-Path: <magnus.damm@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 61C372BEA0
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Dec 2004 01:54:50 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 49so259888wri
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Dec 2004 06:54:48 -0800 (PST)
Message-ID: <aec7e5c304121106482fcdba62@mail.gmail.com>
Date: Sat, 11 Dec 2004 15:48:07 +0100
From: Magnus Damm <magnus.damm@gmail.com>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_164_2615098.1102776487641"
Subject: [PATCH] drivers/ide/ppc/mpc8xx.c - volatile fix
Reply-To: Magnus Damm <magnus.damm@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_164_2615098.1102776487641
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I fixed this in a local tree for a customer half a year ago (mvl-3.1)
and forgot to report it to the lists. Now I came across it in vanilla
2.5.10-rc3. I have not tested the fix but it is pretty obvious that
access with a non-volatile pointer to hardware is bad, at least with
gcc-3 or above.

Please apply. Or ignore if already fixed. =)

Thanks.

/ magnus (needs CC)

------=_Part_164_2615098.1102776487641
Content-Type: application/octet-stream;
	name="linux-2.6.9-mpc8xx-volatile.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.9-mpc8xx-volatile.patch"

LS0tIGxpbnV4LTIuNi45L2RyaXZlcnMvaWRlL3BwYy9tcGM4eHguYwkyMDA0LTEyLTExIDEzOjA1
OjA5LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjktbXBjOHh4LXZvbGF0aWxlL2RyaXZl
cnMvaWRlL3BwYy9tcGM4eHguYwkyMDA0LTEyLTExIDE1OjQ5OjE2LjAwMDAwMDAwMCArMDEwMApA
QCAtMTcyLDcgKzE3Miw3IEBACiAJdm9sYXRpbGUgcGNtY2lhX3dpbl90ICp3aW47CiAJdm9sYXRp
bGUgcGNtY29uZjh4eF90ICpwY21wOwogCi0JdWludCAqcGdjcng7CisJdm9sYXRpbGUgdWludCAq
cGdjcng7CiAJdTMyIHBjbWNpYV9waHlfYmFzZTsKIAl1MzIgcGNtY2lhX3BoeV9lbmQ7CiAJc3Rh
dGljIHVuc2lnbmVkIGxvbmcgcGNtY2lhX2Jhc2UgPSAwOwo=
------=_Part_164_2615098.1102776487641--
