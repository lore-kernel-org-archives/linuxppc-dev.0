Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A153EDDEBC
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 10:26:20 +1100 (EST)
Message-ID: <47CF2C08.5000609@s5r6.in-berlin.de>
Date: Thu, 06 Mar 2008 00:26:00 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 1/2] firewire: endianess fix
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802272221.38985.jwilson@redhat.com>
	<1204179959.15052.372.camel@pasglop>
	<200802281342.06493.jwilson@redhat.com>
	<1204241162.15052.393.camel@pasglop>
	<47C79CB1.6050104@redhat.com> <20080303091927.GA27105@iram.es>
	<47CC0C95.1030709@s5r6.in-berlin.de>
	<20080305225902.GA27985@iram.es>
In-Reply-To: <20080305225902.GA27985@iram.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	Jarod Wilson <jwilson@redhat.com>, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert wrote:
>>> I have a Pismo which I use on a virtually
>>> daily basis (and about to remove the last remnants of MacOS on it). 
>>> However I have disabled Firewire because it would not sleep and wake 
>>> up properly. 
...
> For now I have only tested the new stack with a 6 year old 1.8" disk
> and everything works, including suspend to RAM. The kernel is 2.6.25-rc4
> plus additional pull from linux1394-2.6.git: 2.6.25-rc4-00032-g8d36ba4.

That's great.  Thanks for testing.
-- 
Stefan Richter
-=====-==--- --== --==-
http://arcgraph.de/sr/
