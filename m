Return-Path: <bounces@nabble.com>
Message-ID: <2547937.196031180424819306.JavaMail.nabble@isper.nabble.com>
From: angelalinyao@163.com
To: Linuxppc-embedded@ozlabs.org
Subject: How can I get a ramdisk.image for linux2.6 running on ML403?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 May 2007 00:46:59 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,all
    I used to run linux 2.4 successfully with my ramdisk.image on ML403.Now I'm trying to run linux 2.6 on ML403,however,my ramdisk didn't work. The error was as follow.

RAMDISK: Compressed image found at block 0 
VFS: Mounted root (ext2 filesystem). 
Freeing unused kernel memory: 84k init 
Warning: unable to open an initial console. 

    My ramdisk was provided by MontaVista and suppotted kernel 2.4.Its dev/ is empty because it uses devfs and devfs is selectable in kernel 2.4 while making menuconfig.But in kernel 2.6 devfs is unselectable,so the error occurs with the dev/ empty.
    Is there any ramdisk.image provided for linux 2.6?Or maybe I have to make a ramdisk by myself?If I make a ramdisk by myself,where can I get all the files under dev/?Will the dev/ simply copied from a server or PC which runs linux 2.6 work for ppc405?
    Any help from you is appreciated.Thank you! 
                                                                                                                       linyao
