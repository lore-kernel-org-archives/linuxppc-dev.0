Mime-Version: 1.0
Message-Id: <v04210103b4058cbb5883@[17.203.21.242]>
In-Reply-To: <v04210108b4051bfbea54@[192.168.0.1]>
References: <19990915113905.031280@mailhost.mipsys.com>
 <v04210108b4051bfbea54@[192.168.0.1]>
Date: Wed, 15 Sep 1999 10:53:13 -0700
To: Ethan Benson <erbenson@alaska.net>
From: Kevyn Shortell <kevyn@apple.com>
Subject: Re: New booter
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, here's the story from the horses mouth.

You need to use HFS to boot, no other method is guaranteed to work.
You can call it a kludge if you want to, but while you up there on
the soapbox, you might want to rethink your statement and consider how
Linux boots on X86.

Linux as a OS, has more kludge factor than anything else on the planet
and it works, people use it, life goes on.

No other boot method besides HFS is going to be tested by Apple in
the Firmware, it's not a requirement for shipping machines at this
time. That may change in the future, but for right now, HFS is it.

Kevyn

At 1:58 AM -0800 9/15/99, Ethan Benson wrote:
>On 15/9/99 Benjamin Herrenschmidt wrote:
>
>> >From Apple perspective, it's not a kludge since the final MacOS X will
>>boot from HFS+ partitions, so it seems logical to have the bootinfo on an
>>HFS volume.
>
>well regardless its still a kludge from the linux perspective we 
>don't use HFS..
>
>and besides that its my opinion that relying on a specific 
>filesystem to boot your OS is extremely shortsighted, if later on 
>they want to change there filesystem to something better they can't 
>since there bootfile would not be readable on this new fs, they are 
>then chained to HFS+ forever and end up using kludgy crap like 
>hidden HFS filesystems with the boot files. (and besides this not 
>everyone who wants to use OSX wants to use HFS)
>
>IMNSHO the only way to boot an OS is to have your firmware load 
>whatever is on the disk bootblock which contains the OS loader.  no 
>need to bloat the firmware with filesystem code that will inevitably 
>become obsolete and useless, and you are no longer chained to your 
>current filesystem for all eternity... I have to say that intel 
>hardware is far superior to PPC hardware in this respect, booting 
>arbitrary OSes independently on intel hw is a complete non issue...
>
>anyway regardless of what apple is doing linux is a different OS it 
>does not use HFS and as such using a small useless HFS partition 
>just to boot it is a kludge.
>
>
>
>Ethan Benson
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>OpenPGP encrypted mail accepted.
>To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/
>Key FingerPrint: 371A 7416 5D39 CF2D 9366  8AF6 0139 54F5 3EBD 0FE6
>RSA Key FingerPrint: DE8B 74D0 79F1 6176  9AF5 120F 47AD 9B0A
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>

---------------------------------------------------------------
Kevyn Shortell                    Worldwide Developer Relations
Technology Manager          	  Apple Computer, Inc
kevyn@apple.com                   http://developer.apple.com/
"War doesn't determine who's right. War determines who's left"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
