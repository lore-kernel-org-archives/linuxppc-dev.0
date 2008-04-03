Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: printk time confusion?
References: <1207146186.3957.11.camel@johannes.berg>
	<1207219724.10388.319.camel@pasglop> <jehcejqjpj.fsf@sykes.suse.de>
	<1207221159.3636.44.camel@johannes.berg>
Date: Thu, 03 Apr 2008 13:24:39 +0200
In-Reply-To: <1207221159.3636.44.camel@johannes.berg> (Johannes Berg's message
	of "Thu\, 03 Apr 2008 13\:12\:39 +0200")
Message-ID: <je3aq3qiyw.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arndb@de.ibm.com>, Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

>> >> [  155.982345] ioctl32(gnome-terminal:6543): Unknown cmd fd(31) cmd(0000530b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/8
>
>> > Proably ioctl's that lack a 32 bits conversion, you'll have to dig in
>> > the pty stuff to find out which ones it is and if it can be a problem...
>> 
>> 0x53xx is claimed by cdrom.h, and 0x530b is CDROMSUBCHNL.  Of course, a
>> tty does not implement cdrom ioctls.
>
> Humm ok, then the first question is why gnome-terminal tries that

Perhaps some misconfiguration, I can't reproduce that here (with
2.18.2).

> and the second why it would printk something?

To ease finding missing compat ioctl handlers.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
