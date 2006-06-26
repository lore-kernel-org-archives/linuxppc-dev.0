Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 33062679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 04:17:49 +1000 (EST)
Message-ID: <44A01925.9050100@ovro.caltech.edu>
Date: Mon, 26 Jun 2006 10:28:05 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: sudheer <urwithsudheer@gmail.com>
Subject: Re: Need help ragarding MPC8360 Kernel bootup failure
References: <44A00EF4.6000109@gmail.com>
In-Reply-To: <44A00EF4.6000109@gmail.com>
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



>  CTRL-A Z for help |115200 8N1 | NOR | Minicom 2.00.0 | VT102 |      Offline

Your minicom is set to 115200, so your U-Boot must be using that,
but you'll need to tell Linux too, try:

console=ttyS0,115200

Dave
