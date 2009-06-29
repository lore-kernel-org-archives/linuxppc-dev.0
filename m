Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 83C86B7142
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 02:07:46 +1000 (EST)
Received: from WA4EHSOBE002.bigfish.com (wa4ehsobe002.messaging.microsoft.com
	[216.32.181.12]) by ozlabs.org (Postfix) with ESMTP id 05035DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 02:07:45 +1000 (EST)
Message-ID: <4A48E6C1.70200@am.sony.com>
Date: Mon, 29 Jun 2009 09:07:29 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 13304] New: ehci_hcd module causing problems
	in using usb head phone
References: <Pine.LNX.4.44L0.0906262132120.2995-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0906262132120.2995-100000@netrider.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, USB list <linux-usb@vger.kernel.org>,
	abhishekkumar <abhishekkumar@tataelxsi.co.in>,
	bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2009 06:33 PM, Alan Stern wrote:
> On Fri, 26 Jun 2009, Geoff Levand wrote:
> 
>> > Where is the information about the hardware errata you mentioned?
>> 
>> Sorry, I should have mentioned it.  Unfortunately, that info is not
>> in the public as far as I know.  I think only someone with access
>> to those will be able to work on this fix.
> 
> Okay, then I guess there's nothing more I can do regarding Bug #13304.  
> Can you take it over?

Yes, as I mentioned, it is on my to-do list.  I'll bump up the priority
now that there are two users reporting the problem.

-Geoff
