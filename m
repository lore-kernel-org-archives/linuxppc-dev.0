Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5ED0DB7CF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Mar 2010 03:34:37 +1100 (EST)
In-Reply-To: <1269427815.8599.226.camel@pasglop>
References: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
	<1269427815.8599.226.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4ECC0AA9-8D46-42E9-86C7-E5937FA147FF@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Booting headless PowerMac G5
Date: Wed, 24 Mar 2010 17:53:00 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tony Breeds <tonyb@au1.ibm.com>, Romain Goyet <r.goyet@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The root of the problem is that Apple OF will not open an stdout  
> for you
> on some machines if you don't enter OF manually, so yaboot text never
> shows up. This was somewhat worked around by the ofboot.b script but
> indeed, it seems to fail to check that there's a display to open  
> before
> actually opening it, which cause the failure you are hitting.

Check /chosen/stdout , if it's there and non-zero there is an open
output device (whether some screen or serial or telnet or whatever).
This is an ihandle.

> Maybe we can try to make the script a bit smarter to detect that  
> there's
> nothing there. Hard to tell, the arcanes of Apple OF are quite  
> obscure.

I'll check them all (well, anything in the NewWorld) if you tell me
what to check.


Segher
