Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806091716l9e50ab9xf65c4a90cb5a5343@mail.gmail.com>
Date: Mon, 9 Jun 2008 20:16:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linuxppc-dev list" <Linuxppc-dev@ozlabs.org>
Subject: Re: zImage.chrp is getting gziped on Efika
In-Reply-To: <9e4733910806090555p7d6d768chbc7114f759c3557b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081827u776112c0x497c5ddf0f4667a@mail.gmail.com>
	<9e4733910806090555p7d6d768chbc7114f759c3557b@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This doesn't look right. I don't think vmlinux.strip should be 3.2GB
for the Efika.

rwxr-xr-x  1 jonsmirl jonsmirl   32429434 2008-06-09 20:12 vmlinux
-rw-r--r--  1 jonsmirl jonsmirl   61735424 2008-06-09 20:12 vmlinux.o
-rwxr-xr-x  1 jonsmirl jonsmirl 3224000004 2008-06-08 21:11 vmlinux.strip
-rwxr-xr-x  1 jonsmirl jonsmirl 3224175192 2008-06-09 20:12 vmlinux.strip.21504
-rw-------  1 jonsmirl jonsmirl    2064384 2008-06-09 20:12
vmlinux.strip.21504.gz
-rwxr-xr-x  1 jonsmirl jonsmirl    4477568 2008-06-09 00:17 vmlinux.strip.gz
-rw-r--r--  1 jonsmirl jonsmirl 3224000765 2008-06-08 21:12 zImage.6451.o
jonsmirl@terra:~/es$



-- 
Jon Smirl
jonsmirl@gmail.com
