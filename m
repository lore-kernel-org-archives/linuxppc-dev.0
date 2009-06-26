Return-Path: <stern+4a593f06@rowland.harvard.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B521BB6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 06:42:44 +1000 (EST)
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id B4928DDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 06:42:42 +1000 (EST)
Date: Fri, 26 Jun 2009 16:42:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Bugme-new] [Bug 13304] New: ehci_hcd module causing problems
	in using usb head phone
In-Reply-To: <4A450207.5000502@am.sony.com>
Message-ID: <Pine.LNX.4.44L0.0906261638370.4155-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 26 Jun 2009, Geoff Levand wrote:

> There is a known but yet unfixed bug for the PS3's EHCI Async Periodic
> (typically audio recording) device handling.  There are a few related
> hardware errata that I have not yet implemented driver fixes for that
> I think are causing it.  
> 
> I guess it is the same problem as reported by Abhishek since Andrew's
> dmesg (http://www.osl.iu.edu/~afriedle/dmesg.txt) shows similar 
> results.

Yes, it definitely looks the same.

> More info is here:
> 
>   http://ozlabs.org/pipermail/cbe-oss-dev/2009-February/006365.html
> 
> I have bought a ART Tube USB device but have not had time to fix
> this bug.  It is on my todo list.  Please feel free to make an
> attempt.

Where is the information about the hardware errata you mentioned?

Alan Stern
