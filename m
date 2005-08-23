Return-Path: <scop@digitel.com.br>
Received: from phoenix.digitel.com.br (unknown [200.198.105.46])
	by ozlabs.org (Postfix) with ESMTP id 2365B680E8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 05:10:31 +1000 (EST)
Received: from [10.10.10.4] by phoenix.digitel.com.br (GMS
	10.03.3304/NU1492.00.9fae9071) with ESMTP id lnecrbaa for
	linuxppc-embedded@ozlabs.org; Tue, 23 Aug 2005 16:10:03 -0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: "JohnsonCheng" <johnsoncheng@qnap.com.tw>,
	"'Robert P. J. Day'" <rpjday@mindspring.com>
Date: Tue, 23 Aug 2005 16:16:46 -0300
References: <20050823053209.1B48668053@ozlabs.org>
In-Reply-To: <20050823053209.1B48668053@ozlabs.org>
MIME-Version: 1.0
Message-Id: <200508231616.46897.scop@digitel.com.br>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Johnson,

On Tuesday 23 August 2005 02:31, JohnsonCheng wrote:
> It doesn't work, too.
> Error message: Invalid argument.
Well, do you have an mtdblock4 entry in /dev?

Also, you should specify your filesystem type to mount, like in:

mount -t jffs2 /dev/mtdblock4 /mnt

BTW, -t jffs2 is just an example.

HTH,

-Scop.
