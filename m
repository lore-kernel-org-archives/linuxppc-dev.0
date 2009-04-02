Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id C3F63DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 21:52:24 +1100 (EST)
Message-ID: <49D498E0.80603@mlbassoc.com>
Date: Thu, 02 Apr 2009 04:52:16 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: MPC83xx console : no output after handover
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>	<49D280E0.9020701@mlbassoc.com>	<5ee96a840903311403r331943d2wf9dbb16491f6bc3@mail.gmail.com>	<49D28A7E.2090703@mlbassoc.com>	<5ee96a840903311522t10af5c64n53ab6f834ad475ff@mail.gmail.com>
	<5ee96a840904011153qc052002i8c35229ca3e85c6c@mail.gmail.com>
In-Reply-To: <5ee96a840904011153qc052002i8c35229ca3e85c6c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew L. Creech wrote:
> It turned out that the normally-initialized 8250 driver was getting
> stomped on by my device tree's serial driver (which is also an 8250) -
> apparently CONFIG_SERIAL_8250[_CONSOLE] and CONFIG_SERIAL_OF_PLATFORM
> don't play well together.  Disabling the latter fixed my problem.
> 
> Thanks for the help, and sorry for the noise.
> 

Can you share what you had and what you changed it to?  I'm
running on very similar systems and may face this exact problem
soon.

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
