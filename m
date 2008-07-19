Return-Path: <v.selvamuthukumar@gmail.com>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id 13954DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 21:52:29 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so9276590agc.0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 04:52:28 -0700 (PDT)
Message-ID: <790896390807190452n7197924ma07bfd4c3431eb89@mail.gmail.com>
Date: Sat, 19 Jul 2008 17:22:27 +0530
From: "selvamuthukumar v" <v.selvamuthukumar@gmail.com>
To: "mahendra varman" <mahendravarman15@gmail.com>
Subject: Re: No filesystem could mount root
In-Reply-To: <4ac2955e0807180700u6184562duc128049245e37fdc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4ac2955e0807180700u6184562duc128049245e37fdc@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> NET: Registered protocol family 1
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module
> List of all partitions:
> No filesystem could mount root, tried:  ext3 ext2 msdos ntfs

There are no messages from the kernel that it's trying NFS. You can
check the boot arguments you are passing to the kernel.
