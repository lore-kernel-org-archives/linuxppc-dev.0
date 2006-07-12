Return-Path: <leisun124@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id B283E67B8C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 00:45:05 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id o1so47306nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 07:45:04 -0700 (PDT)
Message-ID: <f9a7e7a80607120738p4587f540wb320ab82a47bdb0d@mail.gmail.com>
Date: Wed, 12 Jul 2006 10:38:18 -0400
From: "Lei Sun" <leisun124@gmail.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: weird behavior for jffs2 on PQ2FADS-VR board
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0300BA@zch01exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f9a7e7a80607112123t7e93221fx37d83245622d4368@mail.gmail.com>
	<4879B0C6C249214CBE7AB04453F84E4D0300BA@zch01exm20.fsl.freescale.net>
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

Hi Dave and Liu:
   Thanks for your reply!
   I will give it a try tonight, I did figure out it's endianess issue
last night, I wrote a little test program writting to /dev/mtd3 and
read it back, they got swapped !

lei
