Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 3274DDE044
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 04:59:00 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2267064ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 09:58:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <497D74E1.6070507@grandegger.com>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205540.31232.77034.stgit@localhost.localdomain>
	<497CC632.2000402@grandegger.com>
	<fa686aa40901251622j542b6029u83c510f5b4e2f92@mail.gmail.com>
	<497D74E1.6070507@grandegger.com>
Date: Mon, 26 Jan 2009 11:58:58 -0600
Message-ID: <b5e2fc790901260958h549dea62o81875bc048c176c3@mail.gmail.com>
Subject: Re: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt controller
	driver
From: Matt Sealey <matt@genesi-usa.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Well, I don't want to debate coding style rules. I also sometimes just
> shake my head. But this rules I actually find useful because it allows
> the GDB to point to the line == expression, apart from readability. If
> you don't stick to the coding style rules, you have to explain to the
> maintainer why you broke it ... good luck ;-).

I thought Grant *WAS* the MPC52xx maintainer :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
