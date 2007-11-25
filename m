Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67F9ADDE2D
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 20:42:48 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Access to PCI Expansion ROMs on PPC
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
Date: Sun, 25 Nov 2007 10:42:42 +0100
In-Reply-To: <20071125015707.GO3174@curie-int.orbis-terrarum.net> (Robin
	H. Johnson's message of "Sat\, 24 Nov 2007 17\:57\:07 -0800")
Message-ID: <jey7cmfyp9.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> I put the card into an amd64 box, found the relevant 'rom' node ($ROM) under
> /sys/device/pci*, and dumped it as follows:
> # echo 1>$ROM

Did you run it exactly like this?  Because this will echo exactly one
newline to $ROM.  If you want to echo "1\n" you need to put a space
between "1" and ">".

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
