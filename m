Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id CC62D67A72
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 21:52:39 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1359610wra
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Apr 2005 04:52:33 -0700 (PDT)
Message-ID: <4240b91605040504525fd877e5@mail.gmail.com>
Date: Tue, 5 Apr 2005 13:52:33 +0200
From: Jerome Glisse <j.glisse@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1112656372.26086.88.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
	<1112656372.26086.88.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I almost successfully run the 2.6.12-rc2, there were some
bad old stuff lying around. But i needed the two workaround
to compile it. So maybe this two could be applied to the kernel ?

Now the only issue which remains is that the radeon framebuffer
no more set a proper mode for my screen. The screen complain
about a out of range mode. But as soon as X start i get a proper
mode set but can't switch to console.

The screen is a crt one on a radeon 9600 with dvi->vga adapter.
Which works well on 2.6.10

I will try t look at radeon framebuffer see if i can find anythings.
Any idea of which change on that code may be the origin of this ?

Jerome Glisse
