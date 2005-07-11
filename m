Return-Path: <DavidHo@nanometrics.ca>
Received: from mail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with SMTP id 4140D67B7A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jul 2005 22:45:40 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF88FF5BDA.0156E295-ON8525703B.00458822-8525703B.00464E95@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Mon, 11 Jul 2005 08:45:51 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: crosstool-0.37
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Thanks to Tim Hayman (my boss =),  Crosstool-0.37 can now build a
cross-compiling GCJ using GCC 4.0.x source and an older GCC core (the GCC
core is used to build glibc which is required for the actual GCC build when
you select more complex features such as C++ and Java).  This is of course
tested on MPC8xx our favourite platform at Nanometrics.

David
