Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D15E2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 19:31:56 +1000 (EST)
Received: from [134.158.40.174] (lpsc0174x.in2p3.fr [134.158.40.174])
 by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id q8A9VptF002935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 11:31:52 +0200
Message-ID: <504DB387.9050904@lpsc.in2p3.fr>
Date: Mon, 10 Sep 2012 11:31:51 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Moving target
References: <503F7555.5060404@lpsc.in2p3.fr>
 <1346369432.18688.10.camel@concordia>
In-Reply-To: <1346369432.18688.10.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/31/2012 01:30 AM, Michael Ellerman wrote:

> I don't think you should be using driver_register().
>
> I think instead you want this to be a platform_driver, and use
> platform_driver_register() ?

Thank you for that. The test engineer was on vacation so it took a while 
before I got feedback on whether it worked or not, and it seems so.
-- 
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
