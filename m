Return-Path: <killyouatonce@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.229])
	by ozlabs.org (Postfix) with ESMTP id A711ADDF35
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Sep 2008 19:18:52 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so2542206qbd.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 01 Sep 2008 02:18:50 -0700 (PDT)
Message-ID: <931ae8260809010218u33b4a42aga6c6359d792deeca@mail.gmail.com>
Date: Mon, 1 Sep 2008 17:18:49 +0800
From: "yanlong wang" <killyouatonce@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8568MDS RAMDISK Problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Hi:
     ram0: rw=0, want=1345772050, limit=1000000, this error cause by
Device Drivers->block device-> ramdisk size
     make ramdisk size bigger~~~~
regards:)
yanlong
