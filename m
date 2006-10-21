Return-Path: <vantranbk@yahoo.com.au>
Received: from web33012.mail.mud.yahoo.com (web33012.mail.mud.yahoo.com
	[209.191.69.127]) by ozlabs.org (Postfix) with SMTP id 2117F67BC9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 19:41:15 +1000 (EST)
Message-ID: <20061021094114.40292.qmail@web33012.mail.mud.yahoo.com>
Date: Sat, 21 Oct 2006 19:41:14 +1000 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: problem when boot new kernel and ramdisk
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1256189444-1161423674=:40271"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1256189444-1161423674=:40271
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi every one
I have just build kernel image and ramdisk for TQM_8xxL
I write image into flash at   40400000 and ramdisk at 40580000 
I run 
=>bootm 40400000 40580000 
and i receive 
## Booting image at 40400000 ...
   Image Name:   Linux-2.6.12-uc0
   Created:      2006-10-21   3:22:00 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    921020 Bytes = 899.4 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 40580000 ...
   Image Name:   
   Created:      2006-10-21   7:54:35 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1853670 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 00deb000, end 00faf8e6 ... OK


and stop run , auto start reboot, after that it still run like this 

Where error ocur? and how can I fix it ?

Thanks

LeVan

 		
---------------------------------
On Yahoo!7
 Photos: Unlimited free storage - keep all your photos in one place!
--0-1256189444-1161423674=:40271
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi every one<br>I have just build kernel image and ramdisk for TQM_8xxL<br>I write image into flash at&nbsp;  40400000 and ramdisk at 40580000 <br>I run <br>=&gt;bootm 40400000 40580000 <br>and i receive <br>## Booting image at 40400000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.12-uc0<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-10-21&nbsp;&nbsp; 3:22:00 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 921020 Bytes = 899.4 kB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>## Loading RAMDisk Image at 40580000 ...<br>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; <br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2006-10-21&nbsp;&nbsp; 7:54:35 UTC<br>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip
 compressed)<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1853670 Bytes =&nbsp; 1.8 MB<br>&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Loading Ramdisk to 00deb000, end 00faf8e6 ... OK<br><br><br>and stop run , auto start reboot, after that it still run like this <br><br>Where error ocur? and how can I fix it ?<br><br>Thanks<br><br>LeVan<br><p>&#32;
		<hr size=1>On Yahoo!7<br> 
<a href= "http://au.rd.yahoo.com/mail/tag/photos/**http%3A%2F%2Fau.photos.yahoo.com%2F">Photos: Unlimited free storage - keep all your photos in one place!</a>
--0-1256189444-1161423674=:40271--
