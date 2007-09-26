Return-Path: <artunmurat@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 32295DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 00:25:21 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so1910152nfd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Sep 2007 07:25:20 -0700 (PDT)
Message-ID: <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com>
Date: Wed, 26 Sep 2007 17:25:19 +0300
From: "Murat Artun" <artunmurat@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: changing the EDLK components
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

In fact I have asked a variant of this question before.

I want to learn the way of building a GNU Automake project and adding
it into ELDK. This could be needed because the current version of an
ELDK component is old to meet the requirements or a library which is
not an ELDK component is to be used in our ppc system.

Section "3.7. Rebuilding ELDK Components" gives details of rebuilding
the components whose source rpms are provided with ELDK.

As I said above I asked a variant of this question to understand how
to build a library in a clean way which is not a part of ELDK.

As now, I need to upgrade an ELDK component. Namely, I need version
0.9.8 of OpenSSL, where latest ELDK release has OpenSSL with version
0.9.7f. I want to learn if it is necessary for me to follow the same
procedure stated in documentation in section "3.7. Rebuilding ELDK
Components". If this is the case, could anyone point me to resources
about how to prepare source rpms from an Automake project to prepare
the source rpm of version 0.9.8 of OpenSSL? Of course building the new
version of the component and placing everything by hand is always a
solution, but I want to understand the clean way of doing this.

Thanks and regards...

-- 
M u r at  A r t u n, MSc.
   Design Engineer

"be conservative in what you do, be liberal in what you accept from others"
