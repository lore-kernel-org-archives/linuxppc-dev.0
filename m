Return-Path: <bwarren@qstreams.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 08530DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 08:22:29 +1100 (EST)
Subject: Reset cause API
From: Ben Warren <bwarren@qstreams.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 05 Mar 2007 16:22:25 -0500
Message-Id: <1173129745.24846.50.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
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

Is there an API call, either Linux or PowerPC-specific, for determining
the cause of the last reset?  I can certainly read the RSR myself, but
why bother if the information's available elsewhere.

thanks,
Ben
