Return-Path: <michaelbarkowski@ruggedcom.com>
Received: from mail.ruggedcom.com (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id E525EB7B7E
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 00:26:56 +1000 (EST)
Message-ID: <4AC60AD8.8030509@ruggedcom.com>
Date: Fri, 02 Oct 2009 10:14:48 -0400
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Is volatile always verboten for FSL QE structures?
Content-Type: text/plain; charset=ISO-8859-1
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just wondering - is there a case where using volatile for UCC parameter RAM for example will not work, or is the use of I/O accessors everywhere an attempt to be portable to other architectures?

I'm asking because I really want to know ;)

-- 
Michael Barkowski
905-482-4577
