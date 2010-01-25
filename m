Return-Path: <kodiakuppercut@gmail.com>
Received: from mail-iw0-f201.google.com (mail-iw0-f201.google.com
	[209.85.223.201]) by ozlabs.org (Postfix) with ESMTP id 3C2181007D6
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 04:06:34 +1100 (EST)
Received: by iwn39 with SMTP id 39so811605iwn.1
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2010 09:06:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C8218436-3EA1-46F0-8E7E-4699AA06005B@kernel.crashing.org>
References: <bc81dc641001212227w429b0f33hab1e541e69a11bf7@mail.gmail.com>
	<C8218436-3EA1-46F0-8E7E-4699AA06005B@kernel.crashing.org>
Date: Mon, 25 Jan 2010 10:06:32 -0700
Message-ID: <bc81dc641001250906o18ba8e9cofbb02421ae046f65@mail.gmail.com>
Subject: Re: Large physical address support on e500 platform
From: Aaron Pace <kodiakuppercut@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Is a simple "hello world" module sufficient to show the issue? =A0I'll lo=
ok into it this week.
>
> - k

It wasn't in my situation, unfortunately.  To duplicate this, I had
one relatively large kernel module, and then one simple 'hello world'
module that did nothing more than call an exported function from the
first module as part of its init.

-Aaron
