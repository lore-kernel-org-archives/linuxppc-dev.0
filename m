Return-Path: <qipnx.tty@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.207])
	by ozlabs.org (Postfix) with ESMTP id 36EF167B58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 20:03:20 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i11so131632nzh
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 03:03:18 -0700 (PDT)
Message-ID: <fcea70de0605170256t24aec90et876b3ccac9ad7a18@mail.gmail.com>
Date: Wed, 17 May 2006 17:56:48 +0800
From: "Hsia Jason" <qipnx.tty@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Is isp1362 compatible to OHCI
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
       Nice to meet you.

       Is isp1362 compatible to OHCI.      The dirvers of 1362 in the
kernel linuxppc_2_4_devel are base on the OHCI.Am I wright?
       However, if 1362 is compatible to OHCI,why some bits in the
Control REGs are missed,and why all the Memory REGs are missed,while
some other REGs ,such as ISO REGs ,are added?
