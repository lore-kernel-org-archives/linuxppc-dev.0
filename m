Return-Path: <segher@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A88FDB70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 23:46:41 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06607DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 23:46:40 +1000 (EST)
In-Reply-To: <20090714133716.GC28970@oksana.dev.rtsoft.ru>
References: <20090616201630.GA4971@oksana.dev.rtsoft.ru>
	<20090714133716.GC28970@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5D56FC27-95F2-4A9A-8955-C6D2A9BC4661@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH RFC 1/2] Makefile: Never use -fno-omit-frame-pointer
Date: Tue, 14 Jul 2009 15:46:51 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Sam Ravnborg <sam@ravnborg.org>, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Sorry for not replying earlier, somehow I missed this mail]

>> On the other hand, *using* -fno-omit-frame-pointer causes gcc to
>> produce buggy code on PowerPC targets.

It doesn't cause the problem, it only exposes it.  And, of course,
only on certain GCC versions.

>> Segher, do you know if all GCC versions that we support for
>> building Linux are behaving the way that GCC manual describe?

I believe so, yes.


Segher
