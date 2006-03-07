Return-Path: <rmcguire@uwbt.com>
Received: from mail19b.g19.rapidsite.net (mail19b.dulles19-verio.com
	[204.202.242.88]) by ozlabs.org (Postfix) with SMTP id 06EB767B18
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 12:57:53 +1100 (EST)
Received: from mx41.stngva01.us.mxservers.net (204.202.242.76)
	by mail19b.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	2-0643446667 for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Mar 2006 20:57:50 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: GNU and Freescale MPC83xx / e300 core support?
Date: Mon, 6 Mar 2006 17:57:41 -0800
Message-ID: <000301c6418a$86b32ee0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.3.1141693203.8543.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I was recently involved in a meeting with a Freescale FAE, which informed us
that the current revisions of the GNU C/C++ compilers do not yet possess any
optimizations for the MPC83xx cores, more precisely no optimizations for the
e300 cores inside the MPC83xx line up.

They did say it was 100% backwards compatible with the existing 603e / 6xx
core support, so all the code should work just fine.

I was curious if anyone out there was aware of any efforts to produce /
patch any of the GNU compilers to have optimizations for these newer
MPC83xx's with the e300 cores? 


Thanks,

-Russ
