Return-Path: <michel@tungstengraphics.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 7AC64DDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 18:00:10 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2057017uge
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Oct 2007 01:00:09 -0700 (PDT)
Subject: Re: Powerbook shuts down hard when hot, patch found
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200709301216.55123.mb@bu3sch.de>
References: <200709282332.52819.mb@bu3sch.de>
	<1191106145.28637.11.camel@pasglop> <200709301213.36821.mb@bu3sch.de>
	<200709301216.55123.mb@bu3sch.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 01 Oct 2007 10:00:02 +0200
Message-Id: <1191225602.28457.22.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-09-30 at 12:16 +0200, Michael Buesch wrote:
> 
> Ah, forgot to say.
> It does not crash immediately when the register is written. It takes about two seconds
> to crash. And when the machine is colder to begin with, it takes slightly
> longer to trigger. That _might_ support your overheating theory.
> 
> Though, it does not trigger when it's up and running, no matter how hot you drive it.

Maybe the thermal control module prevents it from overheating. Have you
tried unloading it or loading it ASAP on bootup to see if that makes any
difference either way?


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
