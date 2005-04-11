Return-Path: <karim@opersys.com>
Received: from www.opersys.com (opersys.com [64.40.108.71])
	by ozlabs.org (Postfix) with ESMTP id 24BBA67B49
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 14:25:06 +1000 (EST)
Message-ID: <4259FA09.8040508@opersys.com>
Date: Mon, 11 Apr 2005 00:16:09 -0400
From: Karim Yaghmour <karim@opersys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii
Subject: 2.6.x with TQM860L
Reply-To: karim@opersys.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I've been trying to get a 2.6.x kernel working with a TQM860L board
with little success. I can get 2.6.11.6 to boot and _sometimes_ get
to a shell, but most of the times it dies while starting init. From
reading the archives, this looks very much like an SDRAM config issue
(i.e. dies mostly when bursting.) Has anyone on this list got a
2.6.x kernel working with the TQM860L?

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
