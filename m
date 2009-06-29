Return-Path: <dhowells@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 63143B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 01:57:34 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id DCF54DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 01:57:33 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
References: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline Assembly queries
Date: Mon, 29 Jun 2009 16:57:16 +0100
Message-ID: <30098.1246291036@redhat.com>
Sender: dhowells@redhat.com
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel mailz <kernelmailz@googlemail.com> wrote:

> asm("sync");

Isn't gcc free to discard this as it has no dependencies, no indicated side
effects, and isn't required to be kept?  I think this should probably be:

	asm volatile("sync");

David
