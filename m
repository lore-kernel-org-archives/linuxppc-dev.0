Message-ID: <3C2080DC.7080307@cymes.de>
Date: Wed, 19 Dec 2001 12:58:20 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: LinuxPPC Mailingliste <linuxppc-dev@lists.linuxppc.org>
Subject: Embedded Function Keys on Powerbook?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I use the Kernel 2.4.16-benh on an Apple Powerbook G3 (Pismo).

The Powerbooks have special keys for brightness, volume, mute, etc
in parallel to the funcion keys F1 to F6. Per default this special keys
are the primary keys and the Function-Keys (together with the Fn-key)
build the secondary keys.

The Mac-OS 9 has a checkbox in the Function-Key-Dialog to "invert" the
Fn-key. Cecked, the Function-Keys are the primary keys and the special
keys work together with Fn.

Question: Has this function already been implemented in the Kernel?
           I found something about the Button-Device in the keyboard
           driver. Is this a feature of the Button-Device?

Also interesting is: When I had checked the checkbox under Mac-OS, the
setting survived all reboots and also with Linux the F1-F6 keys worked
without the Fn-key. But after the machine once awaked from sleep (after
reopen the lid or similar) the setting is resetted to default.

Has anyone information about this feature?

  Matthias Grimm


--
____________________________________________________________________
Matthias Grimm                                        joker@cymes.de
----   Planung ist der Ersatz des Zufalls durch den Irrtum     -----


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
