Return-Path: <alohanono@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 260A4474C1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 22:41:09 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so3643656ugm.14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Dec 2008 03:41:06 -0800 (PST)
Message-ID: <4937C1D1.5010002@gmail.com>
Date: Thu, 04 Dec 2008 12:41:05 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Weird strings in kernel uname when cross-compiling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

 anybody knows why every time I cross-compile my kernel (Denx 4.2 
cross-compiling chain ) I get an extra string in my vermagic like this

2.6.24-rc3-gd7ed933b-dirty

when my kernel's ( secretlabs 2.6.24-rc3) makefile has this parameters:

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 24
EXTRAVERSION = -rc3

(So no -gd7ed933b-dirty anywhere... )

 Having that is a bit annoying when I try to natively compile modules, 
so I need to workaround it by copying  that extra string into my other 
Makefiles. Anybody knows how to get rid of it?

/Albert
