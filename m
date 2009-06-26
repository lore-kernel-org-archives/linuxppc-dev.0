Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 64418B708A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 08:05:27 +1000 (EST)
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id D0154DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 08:05:26 +1000 (EST)
Message-ID: <4A454616.7040501@am.sony.com>
Date: Fri, 26 Jun 2009 15:05:10 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 13304] New: ehci_hcd module causing problems
	in using usb head phone
References: <Pine.LNX.4.44L0.0906261638370.4155-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0906261638370.4155-100000@iolanthe.rowland.org>
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

On 06/26/2009 01:42 PM, Alan Stern wrote:
> On Fri, 26 Jun 2009, Geoff Levand wrote:
> 
>> There is a known but yet unfixed bug for the PS3's EHCI Async Periodic
>> (typically audio recording) device handling.  There are a few related
>> hardware errata that I have not yet implemented driver fixes for that
>> I think are causing it.  
>> 
>> I guess it is the same problem as reported by Abhishek since Andrew's
>> dmesg (http://www.osl.iu.edu/~afriedle/dmesg.txt) shows similar 
>> results.
> 
> Yes, it definitely looks the same.
> 
>> More info is here:
>> 
>>   http://ozlabs.org/pipermail/cbe-oss-dev/2009-February/006365.html
>> 
>> I have bought a ART Tube USB device but have not had time to fix
>> this bug.  It is on my todo list.  Please feel free to make an
>> attempt.
> 
> Where is the information about the hardware errata you mentioned?

Sorry, I should have mentioned it.  Unfortunately, that info is not
in the public as far as I know.  I think only someone with access
to those will be able to work on this fix.

-Geoff
