Return-Path: <sinan.awad@med.ge.com>
Received: from ext-ch1gw-2.online-age.net (ext-ch1gw-2.online-age.net
	[216.34.191.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-ch1gw.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 67F4867BF8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Dec 2006 19:04:33 +1100 (EST)
Received: from int-ch1gw-5.online-age.net (int-ch1gw-5 [3.159.232.69])
	by ext-ch1gw-2.online-age.net (8.13.6/8.13.6/20051111-SVVS-TLS-DNSBL)
	with ESMTP id kBI84OQV006204 for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Dec 2006 03:04:29 -0500 (EST)
Received: from cinmlef01.e2k.ad.ge.com (int-ch1gw-5 [3.159.232.69])
	by int-ch1gw-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id kBI85Yeq009482 for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Dec 2006 03:05:35 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Ltib on PowerQUICC 8349
Date: Mon, 18 Dec 2006 09:07:01 +0100
Message-ID: <22A704B880BBD94A9E52BD6FA90C63D78A316D@BUDMLVEM08.e2k.ad.ge.com>
In-Reply-To: <mailman.2.1166403603.4018.linuxppc-embedded@ozlabs.org>
From: "Awad, Sinan \(GE Healthcare\)" <sinan.awad@med.ge.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all

Downloaded LTIB tgz (I'm behind a heavy proxy in my organization).
Configures .ltibrc to have a proxy as explained, I run ./ltib, it takes
a while but then fails on connectivity problems.
When I try to do a wget from the same location (bitshrine/gpp/...) I
succeed, so why ltib isn't ?

Thanks in advance

------------------------------------------------------------------------
Processing platform: host support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
(see logfile: /xxxxx/sinan/dev/linux/ltib-6.2.2-sv/host_config.log)
using=20

Processing: rpm-fs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Can't get GPP index, proxy forced off
Testing ppp_url connectivity: FAIL, disabling
Testing gpp_url connectivity: FAIL, disabling
No network download connection available

Started: Mon Dec 18 08:45:51 2006
Ended:   Mon Dec 18 08:49:14 2006
Elapsed: 203 seconds

Build Failed
---------------------------------------------------------------------

-----Original Message-----
From: linuxppc-embedded-bounces+sinan.awad=3Dge.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+sinan.awad=3Dge.com@ozlabs.org] On
Behalf Of linuxppc-embedded-request@ozlabs.org
Sent: Monday, December 18, 2006 3:00 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 28, Issue 31

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linuxppc-embedded digest..."
