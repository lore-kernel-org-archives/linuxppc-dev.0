Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83]) by ozlabs.org (Postfix) with SMTP id 82DDB67ACD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 17:07:42 +1100 (EST)
Received: from kilbil (unknown [192.168.1.59])
	by india.tejasnetworks.com (*****) with ESMTP id 91BA59B322
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 11:24:52 +0530 (IST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: robin <robin@india.tejasnetworks.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 10 Feb 2005 11:37:07 +0530
References: <20050204192117.4F29CC108D@atlas.denx.de>
In-Reply-To: <20050204192117.4F29CC108D@atlas.denx.de>
MIME-Version: 1.0
Message-Id: <200502101137.07711.robin@india.tejasnetworks.com>
Subject: Memory leak problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
We have an application running on  denx linux kernel 2.4.20.

Apparently there is a memory leak that we are not able to find.
The application is giving out of memory error. Even if we restart=20
the application without rebooting the kernel, (killing all application=20
processes and restarting), it gives the same out of memory error.=20
Rebooting the kernel solves the problem.

It seems that the memory leak is not at the application level
'cos restarting the application doesnt solve the problem..

1. Any ideas where I should look for the leak??
2. Is there any known memory leak problems with the kernel??

Thanks in advance,
Robin
