Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Julien Eyries" <julien.eyries@thales-bm.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel command line for CRAMFS root filesystem 
Date: Thu, 6 Jun 2002 07:32:03 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEEIDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CFF6EDD.9060602@thales-bm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> i have a cramfs image in flash, at address 0xfe100000 (length of image
> is 2MBytes).
> what is the kernel command line "root=..." to use this image as root
> filesystem ?

What is the device name when you mount it from a bootp session? The name is
probably the same...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
