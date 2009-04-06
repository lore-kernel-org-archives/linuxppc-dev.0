Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BCF4DDDB2
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 10:24:04 +1000 (EST)
Date: Mon, 6 Apr 2009 10:24:04 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: CONFIG_PREEMPT and High Resolution Timers problem
Message-ID: <20090406002404.GD16602@bilbo.ozlabs.org>
References: <f234e2140904040516w7db57a5fsfaa6a8674d707bdd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <f234e2140904040516w7db57a5fsfaa6a8674d707bdd@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 04, 2009 at 05:46:38PM +0530, Vijay Nikam wrote:

Hello Vijay.

> Because while searching some information regarding this I learned
> about High-Res Timers. In linux-2.6.20 x86 has this feature enabled
> rather you can enable it but not for powerpc arch, Right ? ? ? If yes
> then is there any way to add CONFIG_HIGH_RES_TIMERS feature to
> linux-2.6.20, any patch available ? ? ?  otherwise what could be the
> option ? ? ?

Getting high res times wrkign in 2.6.20 will be painful, the easyest option to
get HR timers wouyld be to grab 2.6.24 (or newer).  Of course that may cause
other pain for you.

Yours Tony
