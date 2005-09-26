Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 4675E683D2
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 09:40:12 +1000 (EST)
To: Josh Boyer <jwboyer@jdub.homelinux.org>
References: <523bnrsak3.fsf@cisco.com>
	<1127777773.25579.7.camel@yoda.jdub.homelinux.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 26 Sep 2005 16:40:06 -0700
In-Reply-To: <1127777773.25579.7.camel@yoda.jdub.homelinux.org> (Josh
	Boyer's message of "Mon, 26 Sep 2005 18:36:12 -0500")
Message-ID: <52y85jqtyh.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Change #if CONFIG_6xx -> #if defined(CONFIG_6xx) in
 perfmon.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Josh> Ben H. already sent out this patch.  See the thread called
    Josh> "ppc: fix stupid thinko in oprofile fix" :).

OK, thanks.  Drop this one then...

 - R.
