Return-Path: <CFRIESEN@nortel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 711C7B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 09:02:17 +1000 (EST)
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 920E1DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 09:02:16 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id
	n69MfKR20634
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2009 22:41:20 GMT
Message-ID: <4A567270.4040300@nortel.com>
Date: Thu, 09 Jul 2009 16:42:56 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: question on powerpc pthread mutexes and memory barriers
References: <4A565EEB.9020607@nortel.com>
In-Reply-To: <4A565EEB.9020607@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chris Friesen wrote:
> Hi all,
> 
> This probably isn't the right place to ask about this, but does anyone
> know where the implied memory barrier happens for pthread mutexes in the
> uncontended case?  I'm looking at the glibc code and I don't see any
> barrier instructions for mutexes, only semaphores and spinlocks.

Bad form to follow up on my own question, but I tracked it down.   The
barriers are there hidden in the atomic macros.

Sorry for the noise.

Chris
