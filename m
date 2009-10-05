Return-Path: <wlpstxzhd@gmail.com>
Received: from mail-ew0-f210.google.com (mail-ew0-f210.google.com
	[209.85.219.210]) by ozlabs.org (Postfix) with ESMTP id 7BC01B7BC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 03:51:19 +1100 (EST)
Received: by ewy6 with SMTP id 6so1152257ewy.6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 05 Oct 2009 09:51:16 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 Oct 2009 17:51:15 +0100
Message-ID: <6b2212cb0910050951r2fbf5c2eoad8870469ccd5ef5@mail.gmail.com>
Subject: ramdisk decompression error
From: Yixuan Qin <wlpstxzhd@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016364d265b0d7e6b047532ec5b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364d265b0d7e6b047532ec5b
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

I'm new to this list. I'm installing the Embedded Linux on a Xilinx FPGA
PPC405. The first question is that I have 1GB memory, and passed the
standalone memory test. But when installing linux, I have to setup only to
use 512MB memory in the device tree in order to boot the linux successfully,
otherwise it gave an error of stack overflow. The second question is when I
use a small size ramdisk, i.e. 4MB, the linux boots successfully, but when I
use bigger one, i.e. 16MB, it fails most of the time, but in rare case, it
succeeds. It either complains ramdisk decompression error, or cannot find
init. It looks my system is very unstable, I recon it's the problem of
memory, but it already passed with the whole memory test. Could you expert
give any suggestion?

Many thanks,

Simon

--0016364d265b0d7e6b047532ec5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>I&#39;m new to this list. I&#39;m installing the Embedded =
Linux on a Xilinx FPGA PPC405. The first question is that I have 1GB memory=
, and passed the standalone memory test. But when installing linux, I have =
to setup only to use 512MB memory in the device tree in order to boot the l=
inux successfully, otherwise it gave an error of stack overflow. The second=
 question is when I use a small size ramdisk, i.e. 4MB, the linux boots suc=
cessfully, but when I use bigger one, i.e. 16MB, it fails most of the time,=
 but in rare case, it succeeds. It either complains ramdisk decompression e=
rror, or cannot find init. It looks my system is very unstable, I recon it&=
#39;s the problem of memory, but it already passed with the whole memory te=
st. Could you expert give any suggestion?<br>
<br>Many thanks,<br><br>Simon<br>

--0016364d265b0d7e6b047532ec5b--
