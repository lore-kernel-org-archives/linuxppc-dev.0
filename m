Return-Path: <cristian.axenie@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 2E7B1DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 23:12:38 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1475482fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 04:12:36 -0800 (PST)
Message-ID: <9c789a000811150412j11ab836t4dc3be8e7d4a8811@mail.gmail.com>
Date: Sat, 15 Nov 2008 14:12:36 +0200
From: "Cristian Axenie" <cristian.axenie@gmail.com>
To: "Nicholas Mc Guire" <hofrat@hofr.at>, linuxppc-embedded@ozlabs.org,
	"Joachim Foerster" <mls.JOFT@gmx.de>
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <9c789a000811150315u3e390a49gf8fa16c16adfbf51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17414_33398475.1226751156690"
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
	<9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
	<Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
	<9c789a000811150217o3c08e94ar3f99eda848822e62@mail.gmail.com>
	<Pine.LNX.4.58.0811150138440.4494@vlab.hofr.at>
	<9c789a000811150315u3e390a49gf8fa16c16adfbf51@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_17414_33398475.1226751156690
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So I mounted the ext2.img on my host and the /dev/console is not a regular
file. If it helps or clears some aspects this is the contetnt of
rootfs_devices.tab used at the ext2.img generation :

#<name>    <type> <mode> <uid> <gid> <major> <minor> <start>  <inc>  <count>
/dev            d  755  0       0        -      -       -       -       -
/dev/console    c  640  0       0        5      1       -       -       -
/dev/fb0        c  640  0       0       29      0       -       -       -
/dev/full       c  640  0       0        1      7       -       -       -
/dev/hda        b  640  0       0        3      0       -       -       -
/dev/hda        b  640  0       0        3      1       1       1       16
/dev/kmem       c  640  0       0        1      2       -       -       -
/dev/mem        c  640  0       0        1      1       -       -       -
/dev/mtd        c  640  0       0       90      0       0       2       16
/dev/mtdblock   b  640  0       0       31      0       0       1       16
/dev/mtdr       c  640  0       0       90      1       0       2       16
/dev/nftla      b  640  0       0       93      0       -       -       -
/dev/nftla      b  640  0       0       93      1       1       1       8
/dev/nftlb      b  640  0       0       93      16      -       -       -
/dev/nftlb      b  640  0       0       93      17      1       1       8
/dev/null       c  640  0       0        1      3       -       -       -
/dev/ptyp       c  640  0       0        2      0       0       1       10
/dev/ptypa      c  640  0       0        2      10      -       -       -
/dev/ptypb      c  640  0       0        2      11      -       -       -
/dev/ptypc      c  640  0       0        2      12      -       -       -
/dev/ptypd      c  640  0       0        2      13      -       -       -
/dev/ptype      c  640  0       0        2      14      -       -       -
/dev/ptypf      c  640  0       0        2      15      -       -       -
/dev/ram        b  640  0       0        1      0       0       1       2
/dev/ram        b  640  0       0        1      1       -       -       -
/dev/rtc        c  640  0       0       10      135     -       -       -
/dev/tty        c  640  0       0        4      0       0       1       4
/dev/tty        c  640  0       0        5      0       -       -       -
/dev/ttyS       c  640  0       0        4      64      0       1       8
/dev/ttyp       c  640  0       0        3      0       0       1       10
/dev/ttypa      c  640  0       0        3      10      -       -       -
/dev/ttypb      c  640  0       0        3      11      -       -       -
/dev/ttypc      c  640  0       0        3      12      -       -       -
/dev/ttypd      c  640  0       0        3      13      -       -       -
/dev/ttype      c  640  0       0        3      14      -       -       -
/dev/ttypf      c  640  0       0        3      15      -       -       -
/dev/zero       c  640  0       0        1      5       -       -       -

Am I missing something ??? The ext2 formatting of the USB Flash Stick is
influencing this ?
 Can you spot a probable cause ?
Thank you !
Cristian

------=_Part_17414_33398475.1226751156690
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So I mounted the ext2.img on my host and the /dev/console is not a regular file. If it helps or clears some aspects this is the contetnt of rootfs_devices.tab used at the ext2.img generation :<br><br>#&lt;name&gt;&nbsp;&nbsp;&nbsp; &lt;type&gt; &lt;mode&gt; &lt;uid&gt; &lt;gid&gt; &lt;major&gt; &lt;minor&gt; &lt;start&gt;&nbsp; &lt;inc&gt;&nbsp; &lt;count&gt;<br>
/dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d&nbsp; 755&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/console&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/fb0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 29&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>
/dev/full&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/hda&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/hda&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<br>
/dev/kmem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/mem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/mtd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<br>
/dev/mtdblock&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<br>/dev/mtdr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 90&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16<br>/dev/nftla&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>
/dev/nftla&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>/dev/nftlb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/nftlb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 93&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
/dev/null&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ptyp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<br>/dev/ptypa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>
/dev/ptypb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ptypc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ptypd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>
/dev/ptype&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ptypf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ram&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
/dev/ram&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/rtc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 135&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/tty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
/dev/tty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ttyS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>/dev/ttyp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10<br>
/dev/ttypa&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ttypb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ttypc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>
/dev/ttypd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ttype&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>/dev/ttypf&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br>
/dev/zero&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c&nbsp; 640&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -<br><br>Am I missing something ??? The ext2 formatting of the USB Flash Stick is influencing this ?<br>&nbsp;Can you spot a probable cause ?<br>Thank you !<br>
Cristian<br><br>

------=_Part_17414_33398475.1226751156690--
