Return-Path: <peterh@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA72467A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 06:11:29 +1100 (EST)
Received: from evilmonkey.corp.google.com (evilmonkey.corp.google.com
	[172.24.0.124]) by smtp-out.google.com with ESMTP id k2EJ1KOB015581
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 11:01:20 -0800
Received: from smtp-out2.google.com (fpx19.prod.google.com [10.253.24.19])
	by evilmonkey.corp.google.com with ESMTP id k2EFpciH014121
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 11:01:15 -0800
Received: by smtp-out2.google.com with SMTP id 19so28154fpx
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 11:01:15 -0800 (PST)
Message-ID: <50e923300603141101w348a543ci39628aaeb5bc3513@mail.google.com>
Date: Tue, 14 Mar 2006 11:01:15 -0800
From: "Peter Hanson" <peterh@google.com>
To: Ben <Ben@haliplex.com>
Subject: Re: buildroot uClibc busybox and associated tool versions
In-Reply-To: <loom.20060314T023032-451@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <loom.20060314T023032-451@post.gmane.org>
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

No direct answers, but look for lots of useful userland stuff via
Pengutronix PTXdist:
 =3D> http://www.pengutronix.de/software/ptxdist_en.html

And have you looked at Crosstool?
 =3D> http://kegel.com/crosstool/

You may find the results section especially useful if you want to
start with combinations that have already been found to work.
