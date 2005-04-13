Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id DDCD367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 22:32:27 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so90069wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 05:32:26 -0700 (PDT)
Message-ID: <9b7ca65705041305327bd600f6@mail.gmail.com>
Date: Wed, 13 Apr 2005 21:32:25 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Daniel Ann <ktdann@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050413051326.GA12632@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412161230.GA18567@gate.ebshome.net>
	<9b7ca657050412215025872ce3@mail.gmail.com>
	<20050413051326.GA12632@gate.ebshome.net>
Subject: Re: Trying to understand alloc_skb()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/13/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> Then do it. It should be trivial to unwind the stack and much simpler
> than moving this code to process context.

Actually, Im not too sure what is required to put something in kernel
in process context. Maybe its alot harder than I think it is...

> I think it's a bad idea. You are trying to workaround a problem
> instead of fixing it. My experience shows that sooner or later it'll
> come back and hit you anyway :).

I'm with you on this. It just that I didnt think putting my code in
process context would be regarded as workaround. Since kernel itself
ran fine, only after putting in my change it caused problem, I simply
thought that putting changes to code that was already there is more
severe than making further changes to what I've done. At least this
way, change is still within my domain.

But again, if putting my function in process context is that hard..
okay I better think otherwise :)

--=20
Daniel
