Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5B753DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 21:20:46 +1000 (EST)
Message-ID: <46B06C8C.3030106@anagramm.de>
Date: Wed, 01 Aug 2007 13:20:44 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: Embedded linux FTP Server
References: <11935088.post@talk.nabble.com>
In-Reply-To: <11935088.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

khollan schrieb:
> Hey
> 
> Im looking for a basic ftp server to run on my ML410 Xilinx board, I was
> looking on the net and couldn't find anything that stands out.  Does anyone
> have suggestions, or know of something that works well.
> Thanks
> kholland

netkit-ftp seems to be standard.
I am using vsftp because it seems to be good for production.

The
http://vsftpd.beasts.org
http://www.proftpd.org
http://www.wu-ftpd.org
are propably the well known/often used ones.

And there are also tftp servers (trivial ftp)...
if that's what you mean with "basic".
Just choose one from:
http://crux.nu/portdb/?q=ftp&a=search

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
