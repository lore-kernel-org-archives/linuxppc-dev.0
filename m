Return-Path: <rlefevre@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 7D144DDFAF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Oct 2008 06:46:44 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so294475wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Oct 2008 12:46:42 -0700 (PDT)
Message-ID: <4e0b9cb00810091246i2f200dbn9f8dc9877800e629@mail.gmail.com>
Date: Thu, 9 Oct 2008 21:46:42 +0200
From: "Remi Lefevre" <rlefevre@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup (100005/1)
In-Reply-To: <48E393E6.7000505@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>
	<48E262FF.9020108@freescale.com>
	<4e0b9cb00810010636h10c0d1fw3385ecf1f0a27be5@mail.gmail.com>
	<48E393E6.7000505@freescale.com>
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

Ok, I'm sorry, I have incorrectly set the 60x pipeline depth to 0
instead of 1 in BCR register.
It works fine now. The side effect is interesting to know...

regards,
r=E9mi
