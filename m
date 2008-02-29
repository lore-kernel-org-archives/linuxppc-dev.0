Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99722DDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 17:00:58 +1100 (EST)
Subject: Re: [PATCH 1/2] firewire: endianess fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jarod Wilson <jwilson@redhat.com>
In-Reply-To: <47C79CB1.6050104@redhat.com>
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
	<200802281342.06493.jwilson@redhat.com>
	<1204241162.15052.393.camel@pasglop>  <47C79CB1.6050104@redhat.com>
Content-Type: text/plain
Date: Fri, 29 Feb 2008 17:00:27 +1100
Message-Id: <1204264827.15052.413.camel@pasglop>
Mime-Version: 1.0
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Still no luck finding one here. The person I was thinking of has a 
> Lombard, which has no firewire. I did get ahold of a 667MHz Titanium, 
> but its got an Agere FW323. Pretty sure my old man actually has a Pismo, 
> but its about a 3000 mile drive over to my folks house. The search 
> continues... I wonder how many people still actually 1) have a machine 
> with this controller, 2) are running Linux on it and 3) use firewire 
> devices with it. Both of you, please speak up, we're trying to help you! 
> (if only out of morbid curiosity to see this mythical goofy controller).

First gen titanium (400/500 Mhz models) might... Paulus has one at home
I think, I'll chase that up here.

Cheers,
Ben.
