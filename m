Return-Path: <surendra.yadav@softdel.com>
Received: from softdel.com (unknown [202.68.143.18])
	by ozlabs.org (Postfix) with ESMTP id 9882367A6C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 23:02:52 +1000 (EST)
Received: from surendraw2k ([192.168.10.91]) by softdel.com ([192.168.10.4])
	with SMTP (MDaemon.PRO.v6.0.2.R)
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 18:25:46 +0530
From: "Surendra Yadav" <surendra.yadav@softdel.com>
To: <linuxppc-dev@ozlabs.org>
Date: Tue, 26 Apr 2005 18:35:47 +0530
Message-ID: <BPEMKMADCCCPHPEDDKOOCEDLCEAA.surendra.yadav@softdel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: gdbserver problem on powerpc.
Reply-To: surendra.yadav@softdel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I downloaded gdb-6.0 and cross compiled gdbserver for powerpc platform.

When gdbserver I tried to run gdbserver it gives "No such file or
directory".
But I can see this file is present in the bin directory. Even I tried
precompiled binary from ELDK but that also does not work and gives the same
message. Can any one suggest what is the wrong?

I gave the command #gdbserver 192.168.10.243:2345 hello .

Alternatively I tried following command from the bin directory. hello
program is also in the bin the dir. But it won't work.

#./gdbserver 192.168.10.243:2345 ./hello

Regards,
Surendra
