Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB65BDDE3D
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:28:12 +1000 (EST)
Message-ID: <47134F3F.2020901@genesi-usa.com>
Date: Mon, 15 Oct 2007 12:30:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mpc52xx bestcomm patches.
References: <fa686aa40710121130p7ec957bar471c2e8245bd162b@mail.gmail.com>	<903EBFBB-D6B6-42EA-A0E3-63CAA55F6E23@kernel.crashing.org>	<fa686aa40710121154i52e6caa0ve1130ea146b55a3f@mail.gmail.com>
	<DDF4941D-02CA-49FA-999D-8BD08740902C@kernel.crashing.org>
In-Reply-To: <DDF4941D-02CA-49FA-999D-8BD08740902C@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala wrote:
>> The problem is that bestcomm is completely stalled on Sylvain.  He's
>> done good work, but he isn't able to put in the effort for the last
>> push to get it fixed and in.  But until that happens, nobody else will
>> step in to add patches on top of it to fix it up.
> 
> If Sylvain doesn't have the time can't someone else pick up what he's  
> done and fixup the issues with it?

I second that motion!

There are a few minor quibbles I have with Sylvain's implementation (it
seems to have ditched some perfectly sound ideas of the original API plus
additions made by bplan for using the device tree to resolve tasks, in
favour of making the API entirely driver-dependant, and Linux-dependant
(it trashes any existing device table) also it has a few "5200-specific"
features like disabling task prefetch (errata not present in 5200B onwards).

It needs some looking at. But, this can be merged in my opinion, we can
just throw it to the list right now, and take the niggles to the list
and have a discussion about it..

In the absense of one guy hammering at the code let's just get 20 people
to review it, right here, with a new submission..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
