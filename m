Message-ID: <383A971A.B31FBE6D@dalim.de>
Date: Tue, 23 Nov 1999 14:31:06 +0100
From: Stephane GEORGES <sg@dalim.de>
MIME-Version: 1.0
To: svspire@sandia.gov, linuxppc-dev@lists.linuxppc.org
Subject: Re: Partitioning a Sawtooth?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I did work with Benjamin to install linuxPPC on my G4 sawtooth.

I have formated my ide disk like this.
I could not use pdisk.

If you can re-format your hard-drive, use the apple tool to initialize
your drive.
1- Put a HFS+ partition for your Mac OS
2- Put a A/UX root (yes root not swap) for your linux swap (512 MB for
256MB RAM)
3- Put a A/UX swap(yes swap not root) for your linux native (at least
1GB)
4- Put another A/UX swap for data ...
5- ...

Then, your install (Yellow Dog) will recognize all your partitions and
you won't
need to use fdisk (which did not seem to work correctly).

--

/====================================================================/|
| Stephane GEORGES                     |                             ||
| DALiM SOFTWARE GmbH      R&D         |    Tel: +49 7851 9196 40    ||
| Strassburger Str.6                   |    Fax: +49 7851 7357 6     ||
| D-77696                              |                             ||
| Kehl-Sundheim (Germany)              |    E-mail: sg@dalim.de      ||
|____________________________________________________________________|/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
