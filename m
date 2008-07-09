Return-Path: <lmejjad@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id E0B1FDE69B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 00:42:11 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so73100qwb.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jul 2008 07:42:09 -0700 (PDT)
Message-ID: <9b4863980807090742n3c7f7f0bl91ebe85b8d1fe00c@mail.gmail.com>
Date: Wed, 9 Jul 2008 10:42:09 -0400
From: "mejjad lahcen" <lmejjad@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: merge from arch/ppc to arch/powerpc on lite5200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4642_12390278.1215614529509"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_4642_12390278.1215614529509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hi all of you,
I am working to port linux2.6.26 on board based on lite5200, but the kernel
hangs here ( see output)
# Booting image at ff000000 ...
   Image Name:   Linux-2.6.26-rc9
   Created:      2008-07-09  14:05:34 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1738816 Bytes =  1.7 MB
   Load Address: 00400000
   Entry Point:  00400550
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff200000 ...
   Image Name:   ram disk
   Created:      2008-07-09  14:28:18 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    5878062 Bytes =  5.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 039c3000, end 03f5e12e ... OK
Memory <- <0x0 0x4000000> (64MB)
CPU clock-frequency <- 0x1687d280 (378MHz)
CPU timebase-frequency <- 0x1406f40 (21MHz)
CPU bus-frequency <- 0x501bd00 (84MHz)

zImage starting: loaded at 0x00400000 (sp: 0x03f5ede0)
Allocating 0x3887b8 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x00788e30)...done 0x3683e0 bytes
Using loader supplied ramdisk at 0x39c3000-0x3f5e12e
initrd head: 0x1f8b0808

Linux/PowerPC load: root=/dev/ram rw console=ttyPSC0 ramdisk_size=16000
ip=192.168.0.133:192.168.0.131:192.168.0.2:255.255.255.0::eth0:off
Finalizing device tree... flat tree at 0x795300
:))))))

I compiled ramdisk with arch/powerpc but I got the same problem, I dont know
if someone has reesolved this issue
thanks

------=_Part_4642_12390278.1215614529509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;Hi all of you,<br>I am working to port linux2.6.26 on board based on lite5200, but the kernel hangs here ( see output)<br># Booting image at ff000000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.26-rc9<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-07-09&nbsp; 14:05:34 UTC<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1738816 Bytes =&nbsp; 1.7 MB<br>&nbsp;&nbsp; Load Address: 00400000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00400550<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
## Loading RAMDisk Image at ff200000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; ram disk<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-07-09&nbsp; 14:28:18 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 5878062 Bytes =&nbsp; 5.6 MB<br>
&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 039c3000, end 03f5e12e ... OK<br>Memory &lt;- &lt;0x0 0x4000000&gt; (64MB)<br>CPU clock-frequency &lt;- 0x1687d280 (378MHz)<br>
CPU timebase-frequency &lt;- 0x1406f40 (21MHz)<br>CPU bus-frequency &lt;- 0x501bd00 (84MHz)<br><br>zImage starting: loaded at 0x00400000 (sp: 0x03f5ede0)<br>Allocating 0x3887b8 bytes for kernel ...<br>gunzipping (0x00000000 &lt;- 0x0040d000:0x00788e30)...done 0x3683e0 bytes<br>
Using loader supplied ramdisk at 0x39c3000-0x3f5e12e<br>initrd head: 0x1f8b0808<br><br>Linux/PowerPC load: root=/dev/ram rw console=ttyPSC0 ramdisk_size=16000 ip=192.168.0.133:192.168.0.131:192.168.0.2:255.255.255.0::eth0:off<br>
Finalizing device tree... flat tree at 0x795300<br>:))))))<br><br>I compiled ramdisk with arch/powerpc but I got the same problem, I dont know if someone has reesolved this issue <br>thanks <br>

------=_Part_4642_12390278.1215614529509--
