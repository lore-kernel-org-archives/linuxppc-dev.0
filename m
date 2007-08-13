Return-Path: <cbrown@compunetix.com>
Received: from mail.compunetix.com (mail.compunetix.com [198.144.40.4])
	by ozlabs.org (Postfix) with SMTP id 6C65ADDEE6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 23:19:53 +1000 (EST)
From: "Chuck Brown" <cbrown@compunetix.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC755 L2 Cache data parity error
Date: Mon, 13 Aug 2007 09:07:30 -0400
Message-ID: <003f01c7ddaa$e77805d0$8a09010a@nowwhat>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Did you ever solve this problem?  I have a module with a similar
architecture as the one you described and I can get this same data parity
failure just by making the L2 cache private memory and copying a file into
the L2 cache.

Thanks
Chuck Brown
