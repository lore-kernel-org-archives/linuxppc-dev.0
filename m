Return-Path: <cristiano.cortezia@gmail.com>
Received: from mail-bw0-f212.google.com (mail-bw0-f212.google.com
	[209.85.218.212]) by ozlabs.org (Postfix) with ESMTP id 34E30B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 22:19:04 +1100 (EST)
Received: by bwz4 with SMTP id 4so613854bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 03:19:02 -0800 (PST)
MIME-Version: 1.0
Sender: cristiano.cortezia@gmail.com
Date: Wed, 16 Dec 2009 09:19:02 -0200
Message-ID: <6b1fd8860912160319s54f268bboac35b821e731e84b@mail.gmail.com>
Subject: Porting EP852 based system from kernel 2.4.24 to 2.6.x
From: Cristiano Cortezia <cris_locortez@hotmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174bec1c794bc3047ad6ac45
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174bec1c794bc3047ad6ac45
Content-Type: text/plain; charset=ISO-8859-1

I work on a EP825 (MPC852T) based system running a 2.4.24 linux kernel
(which I didn't bring up in first place). Now I need to bring the board
alive over the latest kernel it may be possible to.

I've managed to cross-compile 2.26.32 kernel using most of the options I
could take from the existing 2.4.24 .config.
I could also download the generated uImage to the board using u-boot 1.0.2.
Uncompressed OK and then hung.

I've checked on mailing lists that the 2.6 series works with dts
(device-tree-sources). There are built-in make targets to generate images
backward compatibles with ancient u-boot versions. Then I tried one of these
targets to build a cuImage.xxx, but trying to boot from it also hangs. I
guess there is no make target that correspond to EP852.

Could someone point me some directions on what should I probably be missing
(from the very start of the "default porting procedure") ?

--0015174bec1c794bc3047ad6ac45
Content-Type: text/html; charset=ISO-8859-1

<span id="_ctl0_dgMessages__ctl2_lblPost">I work on a EP825 (MPC852T)
based system running a 2.4.24 linux kernel (which I didn&#39;t bring up in
first place). Now I need to bring the board alive over the latest
kernel it may be possible to. <br>
<br>I&#39;ve managed to cross-compile 2.26.32 kernel using most of the options I could take from the existing 2.4.24 .config. 
<br>I could also download the generated uImage to the board using u-boot 1.0.2. Uncompressed OK and then hung.
<br>
<br>I&#39;ve checked on mailing lists that the 2.6 series works with dts (device-tree-sources).
There are built-in make targets to generate images backward compatibles
with ancient u-boot versions. Then I tried one of these targets to
build a cuImage.xxx, but trying to boot from it also hangs. I guess
there is no make target that correspond to EP852.
<br>
<br>Could someone point me some directions on what should I probably be missing (from the very start of the &quot;default porting procedure&quot;) ? 
</span>

--0015174bec1c794bc3047ad6ac45--
